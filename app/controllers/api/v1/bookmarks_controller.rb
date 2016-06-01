require 'nokogiri'
require 'open-uri'

class Api::V1::BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all

    render json: @bookmarks
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    render json: @bookmark
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @scraped = Nokogiri::HTML(open(@bookmark.url))
    @bookmark.scraped_content = ''
    @scraped.css('h1,h2,h3,h4,h5,h6,a,p').each do |html_elem|
      @bookmark.scraped_content += html_elem.text()
    end

    if @bookmark.save
      render json: @bookmark, status: :created, location: @bookmark
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      head :no_content
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy

    head :no_content
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :name)
  end

end
