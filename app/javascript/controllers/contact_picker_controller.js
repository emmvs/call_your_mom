import { Controller } from "@hotwired/stimulus"

// Define the controller
export default class extends Controller {
  static targets = ['name', 'relationship', 'email', 'phoneNumber', 'address', 'socialMediaHandle', 'contactsList']

  async selectContact() {
    if('contacts' in navigator && 'ContactsManager' in window) {
      const props = await navigator.contacts.getProperties();
      const contacts = await navigator.contacts.select(props, {multiple: false});
      const contact = contacts[0]

      this.nameTarget.value = contact.name;
      this.emailTarget.value = contact.email[0];
      this.phoneNumberTarget.value = contact.tel[0];
    }
  }

  async selectAllContacts() {
    if ('contacts' in navigator && 'ContactsManager' in window) {
      const props = await navigator.contacts.getProperties();
      const contacts = await navigator.contacts.select(props, { multiple: true });
        // Iterate through each selected contact
        const contactsData = contacts.map(contact => ({
          name: contact.name[0],
          email: contact.email?.[0],
          phone_number: contact.tel?.[0],
        }));

      // Send a POST request to your Rails contacts#create endpoint
      this.createContacts(contactsData);
    }
  }

  contactCard(contact) {
    return `<div class="card p-1 rounded m-3"><a class="text-decoration-none" href="/contacts/${contact.id}">${contact.name}</a></div>`
  }

  createContacts(contactsData) {
    fetch('/contacts', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ contacts: contactsData })
    })
    .then(response => {
      if (response.ok) {
        response.json().then((data) => {
          let contactsList = ""
          data.contacts.forEach((contact) => {
            contactsList += this.contactCard(contact)
          })
          this.contactsListTarget.innerHTML = contactsList
        })
      }
    })
  }
}
