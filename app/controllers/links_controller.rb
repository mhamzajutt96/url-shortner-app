# frozen_string_literal: true

# :Links Controller for handling Links Actions:
class LinksController < ApplicationController
  before_action :set_link, only: %i[destroy]

  def index
    @links = Link.order(clicked: :DESC)
  end

  def show
    @link = Link.find_by_slug(params[:slug])
    if @link.nil?
      redirect_to links_path, notice: 'Link does not exist.'
    else
      update_link_attribute(@link)
    end
  end

  def update_link_attribute(link)
    link.update_attribute(:clicked, link.clicked + 1)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to short_path(@link.slug), notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  def destroy
    return unless @link.destroy

    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
