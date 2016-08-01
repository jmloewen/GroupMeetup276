class SocialController < ApplicationController
  def meetup
    #this is a functionality for organizing a group of users.
    #it should get the user location on access and store it.
    @user = current_user
    @user.update_attributes(lat: request.location.latitude, lon: request.location.longitude)
    @user.save
    centralize
  end

  def closest
    #this is functionality for finding the nearest brewery to a given location - this might be a page in page for Meetup?
    #user should perhaps be directed here if not logged in.
  end

  #should eventually take in a user as an 'argument'
  #then will query this group for all users with the user's same 'group value'.
  def centralize
    #testing with brewery location data for now.
    @breweries = Brewery.where(:locality => "Surrey")


    @centralLat = 0

    @breweries.each do |b|
      @centralLat += b.latitude.to_f
    end

    @centralLat = @centralLat / @breweries.count

  end

  def create
    params.permit!
    @group = Group.new(params[:groups])
      if @group.save
        flash[:notice] = "Group Created, user is a member in it"
        current_user.group_id.push(@group.id)
        @current_user.save
        redirect_to '/meetup'
      else
        flash[:notice] = "Group Created, user not in it"#Would this ever be seen?
        # current_user.group_id = @group.group_id
        redirect_to '/meetup'
      end
  end

  #def index
#    @groups = Group.all
#  end

#  def show
#    @group = Group.find(params[:id])
#  end

  def new#needed??????
    @group = Group.new
  end

  def groups
    @allGroups = Group.all
  end

  def group
    @group = Group.find(params[:id])
    @allUsers = User.all
  end

  def remove_self
    current_user.group_id.delete(params[:id].to_f)#.to.f is necassary for num conversion from the string in the URL
    current_user.save
    redirect_to '/groups'
  end

  def accept_membership
    accepted_id = current_user.pending_group_id.delete(params[:id].to_f)
    if accepted_id >= 0
      current_user.group_id.push(accepted_id)
    end
    current_user.save
    redirect_to '/groups'
  end

  def deny_membership
    current_user.pending_group_id.delete(params[:id].to_f)
    current_user.save
    redirect_to '/groups'
  end

end
