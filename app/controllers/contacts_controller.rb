class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def show
    @interaction = Interaction.new
    @interaction.notes.build
    @interactions = @contact.interactions
  end

  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      redirect_to contacts_path
    else
      render :new
    end
  end

  def edit; end

  # TODO: Implement the update logic. You've prepared it with before_action, now you need to:
  # - Attempt to update the contact with contact_params
  # - Redirect or re-render edit based on success or failure
  def update; end

  # TODO: Implement destroy action. Make sure to handle:
  # - Successful deletion with a redirect and notice
  # - Potential errors or issues (if applicable)
  def destroy; end

  private

  def set_contact
    @contact = current_user.contacts.find_by(id: params[:id])
    redirect_to contacts_path, alert: "Contact not found. 🤷🏼‍♀️" unless @contact.present?
  end

  def contact_params
    params.require(:contact).permit(:name, :relationship, :email, :phone_number, :address, :social_media_handle)
  end
end
