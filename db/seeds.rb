# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# DISEASE_DATA = JSON.parse(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/diseases.json"))['diseases']
#
# diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)
#
# diseases.each do |disease|
#   new_disease = MedicalCondition.create(name: disease['name'])
#   puts disease["name"]
#   # taken from rdfs:label
#     disease["alternate_names"].each do |alternate_name|
#       new_disease.alternate_names.create(name: alternate_name)
#     end
#   # Faker data used for causes
#   rand(3).times do
#     new_disease.causes.create(name: Faker::Lorem.word, description: Faker::Company.catch_phrase)
#   end
#
#   disease["codes"].each do |code|
#     new_disease.codes.create(code_system: code["system"], code_value: code["value"])
#   end
# end

# DRUG_DATA = Nokogiri::XML(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/drugbank.xml'))
# drugs = DRUG_DATA.css('/drugbank/drug')
# puts drugs.length
# n=0
# drugs.each do |drug|
#   name = drug.css("/name").text
#   puts drugs.length - n
#   n += 1
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
#
# DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed("/Users/brendapraggastis/Ada/capstone/datafiles/dailymed_dump.json")
# # This returns {dmedcode => {name:----, db_code:----, generic:----, description:----},--=>{..}...}
# # Check medical_therapy_helpers for additional fields
#
# DMED.keys.each do |dkey|  #dkey = primary key for DailyMed record
#   dKey = DMED[dkey] #dKey = the hash for the drug in dailymed record dkey
#   therapy = nil
#   therapy_code = MedicalCode.find_by(code_value: dKey[:db_code])
#   if dKey[:db_code] != nil
#     therapy = therapy_code.medical_code_therapy.medical_therapy if therapy_code != nil
#   end
#   if therapy != nil
#     dmed_code = therapy.codes.find_by(code_system: "DailyMed", code_value: dkey)
#     therapy.codes.create(code_system: "DailyMed", code_value: dkey) if dmed_code == nil
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
#
#
# l = JSON.parse(File.read('https://drive.google.com/file/d/0Bxy3dxgL-9bST3pxS3RGRG1oRFk/view?usp=sharing'))
# l = JSON.parse(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/diseasome_dump.json'))
# l = JSON.parse(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/diseasomesmall.json'))
#
# n = l.keys.length
# l.keys.each do |key|
#   puts n
#   n -= 1
#   name = l[key]['http://schema.org/name'][0]['value'].gsub("_", " ") if l[key]['http://schema.org/name']
#   preventions = l[key]["http://schema.org/primaryPrevention"]
#   if name != nil && preventions != nil
#     diseasealt = AlternateName.find_by(name: name)
#     if diseasealt != nil
#       disease = diseasealt.medical_conditions[0]
#     end
#     if disease != nil
#       preventions.each do |hash|
#         # if nums = hash['value'].match(/http:\/\/beowulf.pnnl.gov\/2014\/drug\/DB\d+/)
#         dcode = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(hash['value'])
#         db, code = dcode[1], dcode[2]
#         if db != nil
#           drug_code = MedicalCode.find_by(
#                                 code_system: "DrugBank",
#                                 code_value: db + code
#                               )
#           drug = drug_code.medical_therapies[0] if drug_code != nil
#         elsif
#           drug_code = MedicalCode.find_by(
#                                 code_system: "DailyMed",
#                                 code_value: code
#                               )
#           drug = drug_code.medical_therapies[0] if drug_code != nil
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
