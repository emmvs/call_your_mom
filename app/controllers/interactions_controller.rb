class InteractionsController < ApplicationController
  def create
    interaction = build_interaction
    medium = find_or_create_medium
    interaction.medium = medium
    build_notes(interaction)

    if interaction.save
      redirect_to contact_path(interaction.contact_id), notice: "Interaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def build_interaction
    Interaction.new(contact_id: params[:interaction][:contact_id], interaction_date: params[:interaction][:interaction_date], user: current_user)
  end

  def find_or_create_medium
    Medium.find_or_create_by(name: params[:interaction][:medium], user: current_user)
  end

  def build_notes(interaction)
    params[:interaction][:notes_attributes]&.each_value do |note_params|
      text = note_params[:text]
      interaction.notes.build(text:) unless text.blank?
    end
  end
end
