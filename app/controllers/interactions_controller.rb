class InteractionsController < ApplicationController
  def create
    interaction = Interaction.new(contact_id: params[:interaction][:contact_id], interaction_date: params[:interaction][:interaction_date])
    interaction.user = current_user

    medium = Medium.find_or_create_by(name: params[:interaction][:medium], user: current_user)

    interaction.medium = medium

    unless params[:interaction][:notes_attributes].values.first[:text].empty?
      interaction.notes.build(params[:interaction][:notes_attributes].values.first)
    end

    if interaction.save
      redirect_to contact_path(interaction.contact_id)
    else
      render :new
    end
  end
end
