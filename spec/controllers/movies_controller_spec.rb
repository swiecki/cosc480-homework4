require 'spec_helper'

describe MoviesController do
  describe 'show a movie' do
    it 'should retrieve a movie' do
      Movie.should_receive(:find).with('1')
      get :show, {:id => '1'}
      response.should render_template('show')
    end
  end

  describe 'show edit form to user' do
    it 'should find the proper information' do
      Movie.should_receive(:find).with('1')
      get :edit, {:id => '1'}
      response.should render_template('edit')
    end
  end

  describe 'show new form to user' do
    it 'should show the form for the user to add new movies' do
      get :new
      response.should render_template('new')
    end
  end

  describe 'create a movie' do
    it 'should create the movie' do
      movie = mock('Movie', :id => '1', :title => 'The Lord of the Rings')
      Movie.should_receive(:create!).and_return(movie)
      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
  end

  describe 'update a movie' do
    it 'should update the movie info' do
      movie = mock('Movie', :id => '1', :title => 'The Lord of the Rings')
      Movie.should_receive(:find).with('1').and_return(movie)
      movie.should_receive(:update_attributes!)
      put :update, {:id => '1', :title => 'The Fellowship of the Ring'}
      response.should redirect_to(movie_path(movie))
    end
  end
  describe 'destroy a movie' do
    it 'should destroy the movie' do
      movie = mock('Movie', :id => '1', :title => 'The Lord of the Rings')
      Movie.should_receive(:find).with('1').and_return(movie)
      movie.should_receive(:destroy)
      delete :destroy, {:id => '1'}
      response.should redirect_to(movies_path)
    end
  end

  describe 'show all movies' do
    it 'should find and show all movies' do
      Movie.should_receive(:all_ratings).and_return(['PG','PG-13','NC-17','G','R'])
      Movie.should_receive(:find_all_by_rating)
      get :index
      response.should render_template('index')
    end
    it 'should redirect when sorting by title' do
      get :index, {:sort => 'title', :ratings => 'R'}
      response.should redirect_to(:sort => 'title', :ratings => 'R')
    end
    it 'should redirect when sorting by rating' do
      get :index, {:sort => 'release_date', :ratings => 'R'}
      response.should redirect_to(:sort => 'release_date', :ratings => 'R')
    end
    it 'should redirect when sorting for a rating' do
      get :index, {:ratings => 'R'}
      response.should redirect_to(:ratings => 'R')
    end
  end
end
