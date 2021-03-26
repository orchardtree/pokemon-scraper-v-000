require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :db
  
  def initialize(pokemon)
    @id = pokemon[:id]
    @name = pokemon[:name]
    @type = pokemon[:type]
    @db = pokemon[:db]
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?);
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
=begin
[1] pry(#<Pokemon>)> db
=> {:id=>1,
 :name=>"Pikachu",
 :type=>"electric",
 :db=>
  #<SQLite3::Database:0x0000000003410bd8
   @authorizer=nil,
   @busy_handler=nil,
   @collations={},
   @encoding=#<Encoding:UTF-8>,
   @functions={},
   @readonly=false,
   @results_as_hash=nil,
   @tracefunc=nil,
   @type_translation=nil>}
[2] pry(#<Pokemon>)>

1) Pokemon .find finds a pokemon from the database by their id number and returns a new Pokemon object

=end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    db.execute(sql, id)
    
  end
end

=begin
  describe ".find" do
    it 'finds a pokemon from the database by their id number and returns a new Pokemon object' do
      # The find method creates a new Pokemon after selecting their row from the database by their id number.
      Pokemon.save("Pikachu", "electric", @db)

      pikachu_from_db = Pokemon.find(1, @db)
      expect(pikachu_from_db.id).to eq(1)
      expect(pikachu_from_db.name).to eq("Pikachu")
      expect(pikachu_from_db.type).to eq("electric")
    end
=end













