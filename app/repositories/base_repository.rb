class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def all
    @elements
  end

  def create(element)
    element.id = @next_id
    @next_id += 1
    @elements << element
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      @elements << build_element(row)
    end
    @next_id = @elements.any? ? @elements.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # array.instance.class.headers
      # Meal.headers
      # Customer.headers
      csv << @elements.first.class.headers # headers
      @elements.each do |element|
        # element is an instance of meal or customer
        csv << element.build_row # csv_row
      end
    end
  end
end
