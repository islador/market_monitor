# https://www.quadratic.net/wiki/index.php/Eve_SQL_of_note
namespace :ccp do
  namespace :dbdump do
    desc "Parse the dumpfile"
    task :parse, [:dbfile] => [:environment] do |t, args|
      args.with_defaults(:dbfile => 'odyssey1-1.db')
 
      @db = SQLite3::Database.open( args.dbfile )

      puts "Database Opened"
      
      @items = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) }
      
      query = "SELECT  productCategory.categoryName item_category,
              productGroup.groupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invBlueprintTypes AS blueprints
      INNER JOIN invTypes AS blueprintType        ON blueprints.blueprintTypeID = blueprintType.typeID
      INNER JOIN invTypes AS productType          ON blueprints.productTypeID   = productType.typeID
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      WHERE blueprintType.groupId IN (SELECT groupId FROM invGroups WHERE categoryId = 9)
        AND blueprintType.published = 1 
        AND blueprints.techLevel = 1
        AND metaType.metaGroupID IS NULL
        AND productCategory.categoryName in ('Ship')
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
              marketGroups.marketGroupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invBlueprintTypes AS blueprints
      INNER JOIN invTypes AS blueprintType        ON blueprints.blueprintTypeID = blueprintType.typeID
      INNER JOIN invTypes AS productType          ON blueprints.productTypeID   = productType.typeID
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      WHERE blueprintType.groupId IN (SELECT groupId FROM invGroups WHERE categoryId = 9)
        AND blueprintType.published = 1 
        AND blueprints.techLevel = 1
        AND metaType.metaGroupID IS NULL
        AND productCategory.categoryName in ('Charge','Drone')
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
              marketGroups.marketGroupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invTypes AS productType
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      where metaType.metaGroupID IS NULL
      AND productCategory.categoryName = 'Material'
      AND marketGroups.marketGroupName in ('Minerals', 'Ice Products','Rogue Drone Components','Salvaged Materials','Fuel Blocks')
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
              marketGroups.marketGroupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invTypes AS productType
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      where productCategory.categoryName = 'Asteroid'
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
              marketGroups.marketGroupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invTypes AS productType
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      where productCategory.categoryName = 'Material'
      And productGroup.groupName in 
        ('Moon Materials', 'Intermediate Materials', 'Composite')
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
        marketGroups.marketGroupName item_group,
        productType.typeName item_name,
        productType.typeID
      FROM invTypes AS productType
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      where productCategory.categoryName in 
      ('Planetary Resources', 'Planetary Commodities')
      
      UNION
      
      SELECT  productCategory.categoryName item_category,
              marketGroups.marketGroupName item_group,
              productType.typeName item_name,
              productType.typeID
      FROM invBlueprintTypes AS blueprints
      INNER JOIN invTypes AS blueprintType        ON blueprints.blueprintTypeID = blueprintType.typeID
      INNER JOIN invTypes AS productType          ON blueprints.productTypeID   = productType.typeID
      INNER JOIN invGroups AS productGroup        ON productType.groupID        = productGroup.groupID
      INNER JOIN invCategories AS productCategory ON productGroup.categoryID    = productCategory.categoryID
      INNER JOIN invMarketGroups AS marketGroups  ON productType.marketGroupID  = marketGroups.marketGroupID
      LEFT OUTER JOIN invMetaTypes AS metaType         ON productType.typeID         = metaType.typeID
      where marketGroups.marketGroupName = 'Capital Ship Components'
      
      Order by item_category, item_group
      
      ".squish
      
      
      @db.query( query ).each do |row|
        min_query = "SELECT t.typeName, m.quantity
        FROM invTypeMaterials AS m
         INNER JOIN invTypes AS t
          ON m.materialTypeID = t.typeID
        WHERE m.typeID = #{row[3]};".squish
        
        mins = @db.query(min_query).collect{|min_row| [min_row[0].downcase.gsub(' ','_').to_sym, min_row[1]]}.inject({}) { |m, e| m[e[0]] = e[1]; m }
 
        if @items[row[0].downcase.gsub(' ','_').to_sym][row[1].downcase.gsub(' ','_').to_sym].empty?
          @items[row[0].downcase.gsub(' ','_').to_sym][row[1].downcase.gsub(' ','_').to_sym] = [{:name => row[2], :type_id => row[3]}.merge(mins)]
        else
          @items[row[0].downcase.gsub(' ','_').to_sym][row[1].downcase.gsub(' ','_').to_sym] << {:name => row[2], :type_id => row[3]}.merge(mins)
        end
        
      end
      
      @regions = @db.query('SELECT regionName, regionID FROM mapRegions where regionName != "Unknown";').collect{|row| {:name => row[0], :region_id => row[1]}}
      
      @items.each_pair do |category, groups|
        puts "#{category}"
        groups.each_pair do |group, items|
          puts "\t#{group}"
          FileUtils.mkdir_p "#{Rails.root}/db/seed/items/#{category}"
          File.open("#{Rails.root}/db/seed/items/#{category}/#{group}.yml",'w') do |out|
            YAML.dump(items, out)
          end
        end
      end
      
      FileUtils.mkdir_p "#{Rails.root}/db/seed/regions"
      File.open("#{Rails.root}/db/seed/regions/region.yml",'w') do |out|
        YAML.dump(@regions, out)
      end
        
    end
    
    desc "Remove Navigateable from Jove systems"
    task :jovian => [:enviroment] do |t, args|
      Region.unscoped.update_all("navigatable = 'f'","name in ('UUA-F4', 'J7HZ-F', 'A821-A')")
    end
  end
end