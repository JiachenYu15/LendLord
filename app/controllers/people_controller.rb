class PeopleController < ApplicationController

    skip_before_action :require_login

    before_action :check_blocked, only:[:show]

    def new
        @person = Person.new
    end

    def create
        @person = Person.new(people_params)
        @person.user_id = current_user.id

        if @person.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        @person = Person.find_by_user_id(current_user.id);
    end

    def show
        @person = Person.find_by_id(params[:id]);
        @is_current_user = true
        @is_current_user_friend = true
        @has_requested = false
        @has_received = false
        @friend = Friend.new

        if current_user.id != Person.find_by_id(params[:id]).user_id
            @is_current_user = false
            _friend1 = Friend.where(["user_from_id = ? and user_to_id = ? and has_accepted = true",current_user.id,@person.user_id])
            _friend2 = Friend.where(["user_to_id = ? and user_from_id = ? and has_accepted = true",current_user.id,@person.user_id])
            if _friend1.blank? and _friend2.blank?
                @is_current_user_friend = false
                  _req1 = Friend.where(["user_from_id = ? and user_to_id = ? and has_accepted = false",current_user.id,@person.user_id]).first
                  _req2 = Friend.where(["user_to_id = ? and user_from_id = ? and has_accepted = false",current_user.id,@person.user_id]).first
                  if _req1.blank? and _req2.blank?
                    @has_requested = false
                    @has_received = false
                  elsif _req1.blank?
                    @has_received = true
                    @friend = _req2
                  else
                    @has_requested = true
                    @friend = _req1
                  end
            elsif _friend1.blank?
                @friend = _friend2
            else
                @friend = _friend1
            end
        end
    end

    def update
        @person = Person.find_by_user_id(current_user.id);
        @person.update(people_params)
        redirect_to personal_home_index_path
    end

    private

        def people_params
            params.require(:person).permit(:username, :firstname, :lastname, :telephone, :country, :state, :city, :address, :addressno)
        end

        def check_blocked
            _check1 = Block.where(["block_from_id = ? and block_to_id = ?", current_user.id, params[:id]])
            _check2 = Block.where(["block_to_id = ? and block_from_id = ?", current_user.id, params[:id]])
            if _check1.blank? and _check2.blank? then
                true
            else
                redirect_to root_path
            end
        end

end
