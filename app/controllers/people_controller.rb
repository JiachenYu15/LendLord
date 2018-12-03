class PeopleController < ApplicationController

    skip_before_action :require_login

    def new
        @person = Person.new
    end

    def create
        @person = Person.new(people_params)
        @person.user_id = current_user.id

        if @person.save
            redirect_to homepage_index_path
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

        if current_user.id != Person.find_by_id(params[:id]).user_id
            @is_current_user = false
        end
    end

    def update
        @person = Person.find_by_user_id(current_user.id);
        @person.update(people_params)
        redirect_to person_path
    end

    private

        def people_params
            params.require(:person).permit(:username, :firstname, :lastname, :telephone, :country, :city, :address)
        end

end
