class EventController < ApplicationController
  include CurrentNumber

  def home
  end

  def find_contact    
    # # @contacts = Contact.search(["p"],1)
    # @contacts = Contact.character_pattern("p%") or Contact.character_pattern("q%")
    # debugger
    set_dial_number # @dial_number_array created includes 0-9 
    # append_array = @dial_number.last.chars      

    create_search_array(@dial_number_array) # this creates @base_array with all search combinations
    
    search(@base_array) # this creates @sorted_array an array of contact:ids ;this need's to sorted asc. 
    

    # @contacts = @sorted_array
    # @contacts = Contact.character_pattern("p%") + Contact.character_pattern("r%")
    # @contacts = Contact.where(id: [1,3,4]) #find_all_by_id([1,3,4]) #depricated
    @contacts = Contact.where("id IN (?) or number like ?", @sorted_array.flatten, "%#{@dial_number_array.join}%").order("name collate NOCASE")
    
    # @sorted_array.each do |sort|
    #   sort.name
    #   sort.number
    # end
    
    respond_to do |format|
      # format.json { render :show, status: :created, location: @contacts }
      format.js {}
      format.html { redirect_to root_path}
    end

  end

  protected

    def set_dial_number
      #do nothing for 10,11,14
      session[:current_number]||=[]
      if not session[:current_number].empty?
        @dial_number_array = session[:current_number].flatten
      end

      @dial_number_array ||= []
      dial_number = params["dial_number"]
      if dial_number == "12" #clear
        @dial_number_array.clear
        # @contacts = Contact.all.order(:name) #shift this logic in create search array
      elsif dial_number == "13" #delete
        @dial_number_array.pop
      elsif (0..9).to_a.include?(dial_number.to_i) 
        @dial_number_array << dial_number
      else
        # nothing
      end
      session[:current_number] = @dial_number_array
    end

    def create_search_array(dial_number_array) # take @dial_number_array; it is actually a array of dialed number.
      std_array = ["abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"]
      @base_array = [] # flush and begin again
      # dial_number_array process all values ; #2-9 work only on this values in dial_number

      #taking care of empty dial_number_array when 12 / 13 is pressed
      if dial_number_array.empty?
        @base_array = [] # empty base array is handled in search
      else
        dial_number_array.each do |dial_number|
          #if dial_number has 0 search only till that point
          if dial_number == 0
            return @base_array #take care of empty array during search!!
          elsif (2..9).to_a.include?(dial_number.to_i) #output @base_array only if dial_number in [2..9] without 0!!
            append_array = std_array[dial_number.to_i-2].chars
            if @base_array.empty?
              @base_array = append_array #for first iteration
            else
              temp_array=[]
              @base_array.each do |base_part|
                append_array.each do |additon_part|
                  temp_array << (base_part.to_s + additon_part.to_s) 
                end
              end
              @base_array = temp_array  #for iterations after first
            end
          end
        end
      end
    end

    def search(base_array)
      @sorted_array =[] # clean sort array
      if base_array.empty?
        @sorted_array << Contact.all.ids
      else
        base_array.each do |value|
          like_value = value + "%"
          # @sorted = @sorted + Contact.character_pattern(like_value)
          @sorted_array << Contact.character_pattern(like_value).ids
        end
      end
    end

    # def event_params
    #   params.permit("dial_number")
    # end

  # def search(character_string,position,sorted)
  #   # contacts = Contact.new # may be redundant
  #   # contacts = Contact.all
  #   # contact_array = []
  #   sorted ||= Contact.new
  #   character_array = character_string.chars
  #   character_array.each do |value|
  #     like_value = "#{"_"*(position-1)}#{value}%"
  #     sorted = sorted + Contact.character_pattern(like_value)
  #   end
  #   return sorted
  # end
end
