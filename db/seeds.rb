# require 'csv'


###################################################################################################################
#
#          Seed 1: Creates MedicalCondition records by name. Creates associated MedicalCode.
#
###################################################################################################################

# **********  File Switch  *******************************************************************************************************************************************
# DISEASE_DATA = JSON.parse(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/diseases.json"))['diseases']
# DISEASE_DATA = JSON.parse(File.open("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseases.json"))['diseases']
# #
#
# ############## Create Initial Seed from list of Outbreak Medical Conditions
#
# mumps = MedicalCondition.create(name: "Mumps", description: "An acute infectious disease caused by RUBULAVIRUS, spread by direct contact, airborne droplet nuclei, fomites contaminated by infectious saliva, and perhaps urine, and usually seen in children under the age of 15, although adults may also be affected. (From Dorland, 28th ed)")
# mumps.codes.create(code_system: "meshid", code_value: "D009107")
# mumps.codes.create(code_system: "image", code_value: "http://www.cdc.gov/mumps/images/glands_image.gif")
# mumps.alternate_names.create(name: "Mumps")
# # Adding description and picture to rubella
# rubella = MedicalCondition.create(name: "Rubella")
# rubella.description = "The incubation period of rubella is 14 days, with a range of 12 to 23 days. Symptoms are often mild, and up to 50% of infections may be subclinical or inapparent. In children, rash is usually the first manifestation and a prodrome is rare. In older children and adults, there is often a 1 to 5 day prodrome with low-grade fever, malaise, lymphadenopathy, and upper respiratory symptoms preceding the rash. The rash of rubella is maculopapular and occurs 14 to 17 days after exposure. The rash usually occurs initially on the face and then progresses from head to foot. It lasts about 3 days and is occasionally pruritic. The rash is fainter than measles rash and does not coalesce. The rash is often more prominent after a hot shower or bath. Lymphadenopathy may begin a week before the rash and last several weeks. Postauricular, posterior cervical, and suboccipital nodes are commonly involved. Arthralgia and arthritis occur so frequently in adults that they are considered by many to be an integral part of the illness rather than a complication. Other symptoms of rubella include conjunctivitis, testalgia, or orchitis. Forschheimer spots may be noted on the soft palate but are not diagnostic for rubella."
# rubella.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/a/ab/Rubella_virus_TEM_B82-0203_lores.jpg")
# rubella.save
# rubella.alternate_names.create(name: "Rubella")
#
# # adding description to malaria
# malaria = MedicalCondition.create(name: "Malaria")
# malaria.description = "Malaria is a mosquito-borne infectious disease of humans and other animals caused by parasitic protozoans (a group of single-celled microorganism) belonging to the genus Plasmodium. Malaria causes symptoms that typically include fever, fatigue, vomiting and headaches. In severe cases it can cause yellow skin, seizures, coma or death. The disease is transmitted by the biting of mosquitos, and the symptoms usually begin ten to fifteen days after being bitten. In those who have not been appropriately treated disease may recur months later. In those who have recently survived an infection, re-infection typically causes milder symptoms. This partial resistance disappears over months to years if there is no ongoing exposure to malaria."
# malaria.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/f/f1/Malaria.jpg")
# malaria.save
# malaria.alternate_names.create(name: "Malaria")
#
# # adding Ebola image and description
# ebola = MedicalCondition.create(name: "Ebola")
# ebola.description = "Ebola, previously known as Ebola hemorrhagic fever, is a rare and deadly disease caused by infection with one of the Ebola virus strains. Ebola can cause disease in humans and nonhuman primates (monkeys, gorillas, and chimpanzees). Ebola is caused by infection with a virus of the family Filoviridae, genus Ebolavirus. There are five identified Ebola virus species, four of which are known to cause disease in humans: Ebola virus (Zaire ebolavirus); Sudan virus (Sudan ebolavirus); Taï Forest virus (Taï Forest ebolavirus, formerly Côte d’Ivoire ebolavirus); and Bundibugyo virus (Bundibugyo ebolavirus). The fifth, Reston virus (Reston ebolavirus), has caused disease in nonhuman primates, but not in humans."
# ebola.codes.create(code_system: "image", code_value: "http://www.utmb.edu/virusimages/images/micrographs/Ebola_virus_2.jpg")
# ebola.save
# ebola.alternate_names.create(name: "Ebola")
#
# # adding Encephalitis
# encephalitis = MedicalCondition.create(name: "Encephalitis, St. Louis", description: "St. Louis encephalitis (SLE) is a viral infection of the brain (encephalitis) that is spread to humans through the bite of infected mosquitoes. Although the virus does not always cause disease, when it does, it can be life-threatening. The SLE virus is part of a group of viruses that are transmitted by blood-sucking insects, such as mosquitoes (arboviruses). Birds, especially domestic fowl, can harbor the virus. As the population of infected birds increase, outbreaks of SLE occur. This disease was first identified in St. Louis, hence the name.")
# encephalitis.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/8/8c/St._Louis_Encephalitis_%28SLE%29_virus_EM_PHIL_1871_lores.JPG")
# encephalitis.alternate_names.create(name: "Encephalitis, St. Louis")
# # West Nile virus
# w = MedicalCondition.create(name: "West Nile Virus")
# w.description = "West Nile virus (WNV) is a mosquito-borne zoonotic arbovirus belonging to the genus Flavivirus in the family Flaviviridae. This flavivirus is found in temperate and tropical regions of the world. It was first identified in the West Nile subregion in the East African nation of Uganda in 1937. The main mode of WNV transmission is via various species of mosquitoes, which are the prime vector, with birds being the most commonly infected animal and serving as the prime reservoir host—especially passerines, which are of the largest order of birds, Passeriformes."
# w.save
# w.codes.create(code_system: "image", code_value: "http://media.worldbulletin.net/250x190/2012/08/30/west-nile-virus.jpg")
# w.alternate_names.create(name: "West Nile Virus")
#
# diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)
#
# diseases.each do |disease|
#   new_disease = MedicalCondition.find_by(name: disease['name']) || MedicalCondition.create(name: disease['name'])
#   puts new_disease.name
#   # taken from rdfs:label
#   disease["alternate_names"].each do |alternate_name|
#     unless new_disease.alternate_names.collect{|x| x.name}.include?(alternate_name)
#       new_disease.alternate_names.create(name: alternate_name)
#     end
#   end
#   disease["codes"].each do |code|
#     new_disease.codes.create(code_system: code["system"], code_value: code["value"])
#   end
#
# end
#
#
# #
# # ###################################################################################################################
# # #
# # #          Seed 2: Creates MedicalTherapy by name, description. Creates associated MedicalCode.
# # #
# # ###################################################################################################################
# #
#
# # **********  File Switch  *******************************************************************************************************************************************
# # DRUG_DATA = Nokogiri::XML(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/drugbank.xml'))
# # puts "loading drugbank file"
# DRUG_DATA = Nokogiri::XML(File.open("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/drugbank.xml"))
# # puts "got past defining drug_data"
# drugs = DRUG_DATA.css('/drugbank/drug')
# # puts drugs.length
# # n=0
# drugs.each do |drug|
#   name = drug.css("/name").text
#   # puts drugs.length - n
#   # n += 1
#   description = drug.css('/description').text
#   d = MedicalTherapy.create(name: name, description: description)
#   d.codes.create(code_value: drug.css('cas-number').text, code_system: "cas-number")
#   d.codes.create(code_system: 'DrugBank', code_value: drug.css('/drugbank-id').first.text)
#   codes = drug.css('/external-identifiers/external-identifier')
#   codes.each do |code|
#     d.codes.create(code_system: code.css('/resource').text, code_value: code.css('identifier').text)
#   end
# end
#
# ###################################################################################################################
# #
# #          Seed 3: Adds MedicalTherapy by name. Creates associated MedicalCode for DrugBank and DailyMed.
# #                  Included generic name as associated AlternateName.
# #
# ###################################################################################################################
#
# # **********  File Switch  *******************************************************************************************************************************************
# # DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/dailymed_dump.json"))
# DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed(File.open("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/dailymed_dump.json"))
#
# # This returns {dmedcode => {name:----, db_code:----, generic:----, description:----},--=>{..}...}
# # Check medical_therapy_helpers for additional fields
# #
# DMED.keys.each do |dkey|  #dkey = primary key for DailyMed record
#   dKey = DMED[dkey] #dKey = the hash for the drug in dailymed record dkey
#   therapy = nil
#   therapy_code = MedicalCode.find_by(code_value: dKey[:db_code])
#   if dKey[:db_code] != nil
#     therapy = therapy_code.medical_code_therapy.medical_therapy if therapy_code != nil
#   end
#   if therapy != nil
#     dmed_code = therapy.codes.find_by(code_system: "DailyMed", code_value: dkey)
#     begin
#       therapy.codes.create(code_system: "DailyMed", code_value: dkey) if dmed_code == nil
#     rescue
#       temp_ar = therapy.codes.map {|code| code.code_system == "DailyMed"? code.code_value : next }
#       puts "DailyMed Duplicate Code! Code value: #{dkey}"
#       if temp_ar.include? dkey
#         puts "Code was already in there"
#       else
#         puts temp_ar.inspect
#         puts "They were trying to put in a second DM code."
#       end
#     end
#     therapy.therapy_alternate_names.create(name: dKey[:generic])
#   else
#     therapy = MedicalTherapy.create(name: dKey[:name], description: dKey[:description])
#     puts therapy.name
#     therapy.therapy_alternate_names.create(name: dKey[:generic][0,255]) if dKey[:generic] != nil
#     therapy.codes.create(code_system: "DrugBank", code_value: dKey[:db_code]) if dKey[:db_code] != nil
#     therapy.codes.create(code_system: "DailyMed", code_value: dkey)
#   end
#
# end
# #
# #
# # ###################################################################################################################
# # #
# # #          Seed 4: Adds drug-disease associations to PrimaryPreventions.
# # #
# # ###################################################################################################################
#
# # # **********  File Switch  *******************************************************************************************************************************************
# # l = JSON.parse(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/diseasome_dump.json'))
# l = JSON.parse(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseasome_dump.json"))
# #
# l.keys.each do |key|
#   name = URI.decode(l[key]['http://schema.org/name'][0]['value']).gsub("_", " ") if l[key]['http://schema.org/name']
#   preventions = l[key]["http://schema.org/primaryPrevention"]
#   if name && preventions
#     diseasealt = AlternateName.find_by(name: name)
#     if diseasealt
#       disease = diseasealt.medical_conditions[0]
#     end
#     if disease != nil
#       preventions.each do |hash|
#         # if nums = hash['value'].match(/http:\/\/beowulf.pnnl.gov\/2014\/drug\/DB\d+/)
#         dcode = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(hash['value'])
#         db, code = dcode[1], dcode[2]
#         if db != nil
#           begin
#             drug_code = MedicalCode.find_by(
#                                   code_system: "DrugBank",
#                                   code_value: db + code
#                                 )
#             drug = drug_code.medical_code_therapy.medical_therapy if drug_code != nil
#           rescue
#             puts "No connection"
#             next
#           end
#         else
#           begin
#             drug_code = MedicalCode.find_by(
#                                   code_system: "DailyMed",
#                                   code_value: code
#                                 )
#             drug = drug_code.medical_code_therapy.medical_therapy if drug_code != nil
#           rescue
#             puts "No connection"
#             next
#           end
#         end
#         if drug != nil
#           puts PrimaryPrevention.create(
#                               medical_therapy_id: drug.id,
#                               medical_condition_id: disease.id)
#         else
#           puts '*'*(80)
#           print "drug: ", dcode
#           print "disease: " , disease.name
#           puts '*'*(80)
#         end
#       end
#     end
#   end
#
# end
#
#
# def parse_drug(string)
#   drug = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(string)
#   return drug[1], drug[2]
# end
#
# #
# # ###################################################################################################################
# # #
# # #          Seed 5: Adds Omim Description to MedicalCondition
# # #
# # ###################################################################################################################
# #
# omim_refs = MedicalCode.select{|name| name.code_system == 'omim' && name.code_value.to_i.to_s === name.code_value}
# omim_refs.each do |code|
#   omim_description = OmimHelpers::Omim::description(code)
#   if omim_description != nil
#     condition = MedicalCode.find_by(
#                           code_system: "omim",
#                           code_value: "#{code["code_value"]}"
#                           ).medical_conditions[0]
#     if condition != nil
#       condition.update(description: omim_description)
#       # puts hash["description"][0,50] if hash["description"]
#       puts condition.name
#
#
#     end
#   end
# end
# #
# #
# #
# # ##################################################################################################################
# #
# #          Seed 6: Place names will be given by name(state/country/territory), and abbreviation
# #
# # ##################################################################################################################
# #
# #
# omim_refs = MedicalCode.select{|name| name.code_system == 'omim' && name.code_value.to_i.to_s === name.code_value}
# omim_refs.each do |code|
#   omim_description = OmimHelpers::Omim::description(code)
#   if omim_description != nil
#     condition = MedicalCode.find_by(
#                           code_system: "omim",
#                           code_value: "#{code["code_value"]}"
#                           ).medical_conditions[0]
#     if condition != nil
#       condition.update(description: omim_description)
#       # puts hash["description"][0,50] if hash["description"]
#       # puts condition.name
#     end
#   end
# end
#
# ##################################################################################################################
#
#          Seed 6: Location data from CSV files
#
# ##################################################################################################################
#
#
# ############# Convert CSV file to JSON ####################
# def is_int?(string)
#   !!(string =~ /^[+-]?[1-9][0-9]*$/)
# end
# #
# # ####--> Replace with correct path name
# lines = CSV.parse(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/us_geo_populated_place.csv"))
# keys = lines.shift
# n = lines.count
#
# File.open("db/support/us_locations.json", "w") do |f|
#   data = lines.map do |values|
#           puts n
#           n -= 1
#           Hash[keys.zip(values.map{|val| is_int?(val) ? val.to_i : val})]
#           end
#   f.puts JSON.pretty_generate(data)
#   f.close
# end
# #
# #
# # ############## Seed Places Table (States and Territories) #############
# lines = CSV.open('db/support/places.csv').readlines
# lines.each do |abbr,region|
#   Place.create(name: region ,abbreviation: abbr)
# end
#
# ############## Seed GEO Table ################
#
#
# #####--> Replace with correct path name
#
# # **********  File Switch  *******************************************************************************************************************************************
# geo_data = JSON.parse(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/us_locations.json"))
# geo_data = JSON.parse(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/us_locations.json"))
#
# geo_data.each do |local|
#   new_geo = Geo.create(
#               name: local["FEATURE_NAME"],
#               latitude: local["PRIM_LAT_DEC"],
#               longitude: local["PRIM_LONG_DEC"],
#               county: local["COUNTY_NAME"],
#               place_id: Place.find_by(abbreviation: local["STATE_ALPHA"] ).id
#               )
#               puts new_geo.name
# end
#
#
#
# sample item from locations.json
# {
#   "FEATURE_ID": 1397658,
#   "FEATURE_NAME": "Ester",
#   "FEATURE_CLASS": "Populated Place",
#   "STATE_ALPHA": "AK",
#   "STATE_NUMERIC": 2,
#   "COUNTY_NAME": "Fairbanks North Star",
#   "COUNTY_NUMERIC": 90,
#   "PRIMARY_LAT_DMS": "645050N",
#   "PRIM_LONG_DMS": "1480052W",
#   "PRIM_LAT_DEC": "64.8472222",
#   "PRIM_LONG_DEC": "-148.0144444",
#   "SOURCE_LAT_DMS": null,
#   "SOURCE_LONG_DMS": null,
#   "SOURCE_LAT_DEC": null,
#   "SOURCE_LONG_DEC": null,
#   "ELEV_IN_M": 221,
#   "ELEV_IN_FT": 725,
#   "MAP_NAME": "Fairbanks D-3",
#   "DATE_CREATED": "12/31/95",
#   "DATE_EDITED": "1/24/09"
# },
##################################################################################################################
#
#        #  Seed 7: Outbreaks and Events
#
##################################################################################################################

# to enter Events:
 # event_hash.keys = {number_infected, date, disease_code, latitude,
 #                    longitude, feature, county, state}
 # medical_condition_id = MedicalCondition.find_by(name: code_hash(disease_code)).id
 # outbreak_id = number given by filename
 # geo_id = Geo.find_by(name: feature).id || Geo.create(.....)
 # we could also use latitude, longitude here for find_by
 # if we need to do a Geo.create then we need to add place_id


###### Outbreaks  Seed:##########

Outbreak.create(title: "Mosquito-borne", description: "Cases of Malaria, Encephalitis and West " +
"Nile Virus found in Louisiana, Florida, Georgia, Mississippi, Arkansas, and Alabama.")
Outbreak.create(title: "Under-vaccination", description: "Cases of Rubella, Mumps, and " +
"in California, Oregon, and Washington due to lack of vaccination.")
Outbreak.create(title: "Ebola", description: "Cases of Ebola occuring in New Jersey and New York State.")

###### Events Seed: Requires DISEASE_HASH and code_hash ###########

DISEASE_HASH = {
  "Rubella" => ["D012409","10018206","N0000002655","36653000","C0035920"],
  "Ebola" => ["D019142","10014071","N0000003898","37109004","C0282687"],
  "Malaria" => ["1385","7728","C03.752.250.552","Malaria","248310"],
  "West Nile Virus" => ["C1096184"],
  "Encephalitis, St. Louis" => ["C0014060"],
  "Mumps" => ["D009107","10009300","N0000002055","240526004","36989005","C0026780"]
}

code_hash = {}
DISEASE_HASH.each do |key,value|
  value.each do |val|
    code_hash[val] = key
  end
end

(1..3).each do |n|
  outbreak = JSON.parse(File.read("db/support/outbreak-#{n}.json"))
  outbreak.each do |event|
    unless g = Geo.find_by(latitude: event["location"]["PRIM_LAT_DEC"], longitude: event["location"]["PRIM_LONG_DEC"])
        pl = Place.find_by(abbreviation: event["location"]["STATE_ALPHA"])
        g = Geo.create(latitude: event["location"]["PRIM_LAT_DEC"],
                   longitude: event["location"]["PRIM_LONG_DEC"],
                   name: event["location"]["FEATURE_NAME"],
                   county: event["location"]["COUNTY_NAME"],
                   place_id: pl.id)
    end
    event["location"]["DATE_CREATED"]? d = Date.strptime(event["location"]["DATE_CREATED"], "%m/%d/%y") : d = nil
    begin
      Outbreak.find(n).events.create(
          date: d,
          medical_condition_id: MedicalCondition.find_by(name: code_hash[event["disease"]]).id,
          number_infected: event["population"].to_i,
          geo_id: g.id)
    rescue
      "!"
    end
  end
end

##################################################################################################################
#
#         Seed 8: MedicalConditionOutbreaks
#
##################################################################################################################

outbreaks = {}
outbreaks[1] = ["Malaria", "West Nile Virus", "Encephalitis, St. Louis"]
outbreaks[2] = ["Rubella", "Mumps"]
outbreaks[3] = ["Ebola"]

# MedicalCondition.create(name: "Encephalitis, St. Louis")

(1..3).each do |n|
  outbreaks[n].each do |item|
    id = MedicalCondition.find_by(name: item ).id
    MedicalConditionOutbreak.create(medical_condition_id: id, outbreak_id: n )
  end
end

##################################################################################################################
#
#         Seed 9: OutbreakPlaces
#
##################################################################################################################

Event.includes(:outbreak, :geo).each do |x|
  OutbreakPlace.create(outbreak_id: x.outbreak.id, place_id: x.geo.place.id)
end
