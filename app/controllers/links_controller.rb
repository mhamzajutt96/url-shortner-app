# frozen_string_literal: true

# :Links Controller for handling Links Actions:
class LinksController < ApplicationController
  before_action :set_link, only: %i[destroy]
  before_action :find_link, only: %i[show shortened]

  def index
    @links = Link.order(clicked: :DESC)
  end

  def show
    update_link_attribute(@link)
    redirect_to @link.sanitize_url
  end

  def update_link_attribute(link)
    link.update_attribute(:clicked, link.clicked + 1)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.sanitize
    if @link.new_url?
      if @link.save
        redirect_to shortened_path(@link.short_url), notice: 'Link was successfully created.'
      else
        render :new
      end
    else
      flash[:notice] = 'A short link for this URL is already present in our database.'
      redirect_to shortened_path(@link.find_duplicate.short_url)
    end
  end

  def shortened
    @link = Link.find_by_short_url(params[:short_url])
    host = request.host_with_port
    @original_url = @link.sanitize_url
    @short_url = host + '/' + @link.short_url
  end

  def fetch_original_url
    fetch_url = Link.find_by_short_url(params[:short_url])
    redirect_to fetch_url.sanitize_url
  end

  def destroy
    return unless @link.destroy

    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private

  def find_link
    @link = Link.find_by_short_url(params[:short_url])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:original_url)
  end
end
