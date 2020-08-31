# frozen_string_literal: true

# :Links Controller for handling Links Actions:
class LinksController < ApplicationController
  before_action :set_link, only: %i[destroy]

  def index
    @links = Link.all
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
    Link.shorten(@link.url)
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
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
