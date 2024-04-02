import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['name', 'relationship', 'email', 'phoneNumber', 'address', 'socialMediaHandle', 'contactsList']

  async selectContact() {
    if (this.canAccessContacts()) {
      const contact = await this.selectContacts(false);
      if (contact) this.assignContactValues(contact);
    }
  }

  async selectAllContacts() {
    if (this.canAccessContacts()) {
      const contacts = await this.selectContacts(true);
      if (contacts.length) this.createContacts(contacts.map(this.contactToData));
    }
  }

  canAccessContacts() {
    return 'contacts' in navigator && 'ContactsManager' in window;
  }

  async selectContacts(multiple) {
    const props = await navigator.contacts.getProperties();
    return navigator.contacts.select(props, { multiple });
  }

  assignContactValues(contact) {
    this.nameTarget.value = contact.name;
    this.emailTarget.value = contact.email[0];
    this.phoneNumberTarget.value = contact.tel[0];
  }

  contactToData(contact) {
    return {
      name: contact.name[0],
      email: contact.email?.[0],
      phone_number: contact.tel?.[0],
    };
  }

  contactCard(contact) {
    return `<div class="card p-1 rounded m-3"><a class="text-decoration-none" href="/contacts/${contact.id}">${contact.name}</a></div>`;
  }

  async createContacts(contactsData) {
    const response = await fetch('/contacts', {
      method: 'POST',
      headers: this.headers(),
      // myJSONString is now '{"name":"Emma","hobby":"Coding"}'
      body: JSON.stringify({ contacts: contactsData })
    });

    if (response.ok) {
      const data = await response.json();
      this.updateContactsList(data.contacts);
    }
  }

  headers() {
    return {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').getAttribute('content')
    };
  }

  updateContactsList(contacts) {
    this.contactsListTarget.innerHTML = contacts.map(contact => this.contactCard(contact)).join('');
  }
}
