class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  def index
    @songs = Song.all
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @artists = Artist.all # used by artist select in view
    # @song = Song.new
    form Song::Create
  end

  # GET /songs/1/edit
  def edit
    @model = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    run Song::Create do |op|
      return redirect_to op.model
    end
    render :new
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    run Song::Update do |op|
      return redirect_to op.model
    end
    render :edit
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :guid, :artist_id)
    end
end
