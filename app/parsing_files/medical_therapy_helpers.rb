module MedicalTherapyHelpers

  class DailyMedSeed

    # Create a list of drug keys from the dailymed seed file

    def self.dailymed(dailymed_file)
      JSON.parse(File.read(dailymed_file))
    end

    def self.daily_drug_keys(dailymed)
      dailymed.keys.select {|key| /dailymed\/resource\/drugs/.match(key)}
    end

    # DAILY_MED = JSON.parse(File.read('db/support/dmedsmall.json'))
    # DRUGS = DAILY_MED.keys.select {|key| /dailymed\/resource\/drugs/.match(key)}

    NAME = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/name"
    DB_CODE = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/genericDrug"
    GENERIC = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/genericMedicine"
    WARNING = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/warning"
    DESCRIPTION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/description"
    INDICATION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/indication"
    CONTRAINDICATION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/contraindication"

    def self.db_code(drug_hash)
      if drug_hash[DB_CODE] != nil
        return drug_hash[DB_CODE][0]["value"].match(/.*\/(DB\d+)/)[1]
      end
    end

    def self.get_value(drug_hash, key_name)
      if drug_hash[key_name] != nil
        drug_hash[key_name][0]["value"]
      end
    end

    # given a single drug hash from dailymedhash pull the wanted values out and place in json file for
    # seeding
    def self.make_one_drug_hash(dailymedvalue)
      temp = {}
      temp[:name] = DailyMedSeed::get_value(dailymedvalue, NAME)
      temp[:db_code] = DailyMedSeed::db_code(dailymedvalue)
      temp[:generic] = DailyMedSeed::get_value(dailymedvalue, GENERIC)
      # temp[:warning] = DailyMedSeed::get_value(dailymedvalue, WARNING)
      temp_descr = DailyMedSeed::get_value(dailymedvalue, DESCRIPTION)
      temp[:description] = temp_descr.gsub(/(\\uFFFD)+/,"-") if temp_descr != nil
      # temp[:indications] = DailyMedSeed::get_value(dailymedvalue, INDICATION)
      # temp[:contraindication] = DailyMedSeed::get_value(dailymedvalue, CONTRAINDICATION
      return temp
    end

    def self.make_daily_med_seed(dailymed_file)
      seed_file = DailyMedSeed::dailymed(dailymed_file) # brings in the json file
      keys = DailyMedSeed::daily_drug_keys(seed_file) # identifies the drug keys
      temp = {}
      keys.each do |dkey|
        value = seed_file[dkey] # this is the hash the drug key points at
        dmed_code = /dailymed\/resource\/drugs\/(\d+)/.match(dkey)[1]
        temp[dmed_code] = DailyMedSeed::make_one_drug_hash(value)
      end
      return temp
    end





    # find the drug therapy with the same code or name
    #add the generic name to alt names, and fill in anything that
    #is missing. Add warning and description as needed.


  end
end

  #Get omim disease descriptions
