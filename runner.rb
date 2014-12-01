# runner.rb
require 'pry'
require 'csv'
# require_relative 'album'

class Album

  def initialize(album_id, album_name, artists)
    @id = album_id
    @title = album_name
    @artists = artists
    @tracks = []
  end
  attr_reader :id, :title, :artists

  def tracks
    @tracks

  end

  def print_tracks
    @track_titles = []
    tracks.each do |track|
      @track_titles << "- #{track[:title]}"
    end
    @track_titles.join("\n")
  end

  def duration_min
    dur_ms = 0
    @tracks.each do |track|
      dur_ms += track[:duration_ms].to_f
    end
    dur_ms / 60000
  end

  def summary
    puts "Name: #{@title}"
    puts "Artist(s): #{@artists}"
    printf("Duration (min.): %.2f\n", duration_min)
    puts "Tracks: "
    puts print_tracks
  end
end

albums = []

CSV.foreach('space_jams.csv', headers: true, header_converters: :symbol) do |row|
  track = row.to_hash
  album = albums.find { |a| a.id == track[:album_id] }

  # if the album hasn't been added to the albums array yet, add it
  if album.nil?
    album = Album.new(track[:album_id], track[:album_name], track[:artists])
    albums << album
  end

  album_tracks = []


  album.tracks << track
end

# print out the summary for each album
albums.each do |album|
  puts album.summary
end
