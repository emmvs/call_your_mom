class ContactsController < ApplicationController
  before_action :set_contact, only: %i[index show edit update destroy]

  def index; end

  def show
    @interaction = Interaction.new
    @interaction.notes.build
    @interactions = @contact.interactions.includes(:notes)
  end

  def new
    @contact = Contact.new
  end

  def create
    return create_response if contacts_saved?

    redirect_with_notice(path: contacts_path, notice: 'Not all contacts were successfully created. 😕')
  end

  def edit; end

  def update
    return redirect_with_notice(path: @contact, notice: 'Contact was updated. 🪄') if @contact.update(contact_params)

    render_edit
  end

  def destroy
    @contact.destroy
    redirect_with_notice(path: contacts_path, notice: 'Contact was deleted. 🗑️', status: :see_other)
  end

  private

  def set_contact
    @contact = Contact.find_by(id: params[:id])
    redirect_with_alert(contacts_path, "Contact not found. 🤷🏼‍♀️") unless @contact
  end

  def set_contacts
    @contacts = current_user.contacts.order(:name)
  end

  def contact_params
    params.require(:contact).permit(:name, :relationship, :email, :phone_number, :address, :social_media_handle)
  end

  def contacts_saved?
    created_contacts&.all?(&:persisted?)
  end

  def created_contacts
    @created_contacts ||= params[:contacts]&.map do |contact_data|
      current_user.contacts.create(contact_data.permit(:name, :email, :phone_number))
    end
  end

  def create_response
    respond_to do |format|
      format.json { render json: { contacts: set_contacts } }
      format.html { redirect_with_notice(path: contacts_path, notice: 'Contacts were successfully created. 📇') }
    end
  end

  def redirect_with_notice(path:, notice:, status: :found)
    redirect_to path, notice:, status:
  end

  def redirect_with_alert(path, alert)
    redirect_to path, alert:, status: :found
  end

  def render_edit
    render :edit, status: :unprocessable_entity
  end
end
