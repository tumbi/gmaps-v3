class MarkersController < ApplicationController
  before_filter :load_character
  
  def index
    @markers = @character.markers
  end
  
  def new
    @marker = @character.markers.build
  end

  def create
    upload_markers
    return redirect_to characters_path
  end

  def edit
    #    @item = Item.find(params[:id])
    @avatar = @item.avatars
    unless @avatars.blank?
      @avatar = @avatars.first
    else
      @avatar = Avatar.new
      #      @avatar = @item.avatars.build
    end
  end
  
  def update
    upload_pics
    redirect_to items_path
  end
  
  def upload_markers
    (0..4).each do |a|      
      unless params[:marker][:markers]['photo_'+a.to_s].blank?
        params[:marker][:markers][:photo] = params[:marker][:markers]['photo_'+a.to_s]
        params[:marker][:markers].delete("#{'photo_'+a.to_s}")
        case a
        when 0          
          params[:marker][:markers][:duration] = "0"
        when 1
          params[:marker][:markers][:duration] = "1"
        when 2
          params[:marker][:markers][:duration] = "7"
        when 3
          params[:marker][:markers][:duration] = "15"
        else
          params[:marker][:markers][:duration] = "30"
        end        
        @marker = @character.markers.build(params[:marker][:markers])
        if @marker.save
          flash[:notice] = "Marker uploaded successfully!"
        else
          flash[:notice] = "Markrer can't be uploaded please try agian or later!"
        end
      end
    end
  end

  def destroy
    #    @avatar = Avatar.find_by_id(params[:id])
    #    if @avatar.destroy
    #      return redirect_to new_item_avatar_path(@item)
    #    else
    #      flash[:notice] = t(:problem_deletin_picture)
    #      return render :action =>"new"
    #    end
  end

  protected
  def load_character
    @character = Character.find(params[:character_id])
    if @character.blank?
      flash[:notice] = "Character not found please try again or later!"
      redirect_to "/"
    end
  end
end