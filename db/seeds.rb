require 'faker'

#Destroy everything
User.destroy_all
University.destroy_all
Course.destroy_all

#Creating basic info
password = 123456
gender = ['masculino', 'feminino', 'other']

highschollers_number = 10
undergraduates_number = 10

highschollers_emails = []
undergraduates_emails = []

for i in 1..highschollers_number
  highschollers_emails << "h#{i}@t.c"
end

for i in 1..undergraduates_number
  undergraduates_emails << "u#{i}@t.c"
end

#Creating highschoolers
highschollers_emails.each do |email|
  User.create!(
    email: email,
    password: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.first_name,
    gender: gender.sample,
    birth_date: Faker::Date.birthday(15, 20),
    city: Faker::Address.city,
    country: Faker::Address.country,
    personal_description: Faker::HowIMetYourMother.quote)
end

#Creating undergraduates
undergraduates_emails.each do |email|
  User.create!(
    email: email,
    password: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.first_name,
    gender: gender.sample,
    birth_date: Faker::Date.birthday(17, 25),
    city: Faker::Address.city,
    country: Faker::Address.country,
    personal_description: Faker::HowIMetYourMother.quote,
    undergraduate: true)
end

#Creating universities
universities = [
  'Universidade de São Paulo (USP)',
  'Universidade Estadual de Campinas (Unicamp)',
  'Universidade Federal do Rio de Janeiro (UFRJ)',
  'Universidade Estadual Paulista (Unesp)',
  'Pontifícia Universidade Católica de São Paulo (PUC-SP)',
  'Pontifícia Universidade Católica do Rio de Janeiro (PUC-Rio)',
  'Universidade Federal de São Paulo (Unifesp)',
  'Universidade Federal do Rio Grande do Sul (UFRS)',
  'Universidade Federal de Minas Gerais (UFMG)',
  'Universidade de Brasília (UnB)',
  'Universidade Federal de São Carlos (Ufscar)',
  'Universidade Federal de Santa Catarina (Ufsc)',
  'Pontifícia Universidade Católica do Rio Grande do Sul (PUC-RS)',
  'Universidade do Estado do Rio de Janeiro (Uerj)',
  'Universidade Estadual de Londrina (UEL)',
  'Universidade Federal da Bahia (UFBA)',
  'Universidade Federal de Santa Maria (UFSM)',
  'Universidade Federal de Viçosa (UFV)',
  'Universidade Federal do Ceará (UFC)',
  'Universidade Federal do Paraná (UFPR)',
  'Universidade Federal de Pernambuco (UFPE)',
  'Universidade Federal Fluminense (UFF)',
]

universities.each do |university|
  University.create!(name: university)
end

# Seed for a restricted number of universities
# universities_number = 10
# for i in 1..universities_number
#   University.create(name: universities.sample)
# end


#Creating courses
courses = [
  "Fonoaudiologia",
  "Administração Pública",
  "Administração",
  "Agronomia",
  "Arquitetura e Urbanismo",
  "Artes Visuais",
  "Biblioteconomia",
  "Biomedicina",
  "Bioquímica e Biotecnologia",
  "Ciência da Computação",
  "Ciência e Tecnologia de Alimentos",
  "Ciências Atuariais",
  "Ciências Biológicas",
  "Ciências Contábeis",
  "Ciências Econômicas",
  "Ciências Sociais",
  "Cinema e Audiovisual",
  "Design",
  "Direito",
  "Educação Física",
  "Enfermagem",
  "Engenharia Aeronáutica",
  "Engenharia Ambiental e Sanitária",
  "Engenharia Bioquímica e de Bioprocessos",
  "Engenharia Civil",
  "Engenharia da Computação",
  "Engenharia de Alimentos",
  "Engenharia de Controle e Automação",
  "Engenharia de Materiais",
  "Engenharia de Minas",
  "Engenharia de Produção",
  "Engenharia de Telecomunicações",
  "Engenharia Elétrica",
  "Engenharia Eletrônica",
  "Engenharia Florestal",
  "Engenharia Mecânica",
  "Engenharia Mecatrônica",
  "Engenharia Metalúrgica",
  "Engenharia Naval",
  "Engenharia Química",
  "Engenharia Têxtil",
  "Esporte",
  "Estatística",
  "Farmácia",
  "Filosofia",
  "Física",
  "Fisioterapia",
  "Fonoaudiologia",
  "Geofísica",
  "Geografia",
  "Geologia",
  "Gerontologia",
  "Gestão Ambiental",
  "História",
  "Informática Biomédica",
  "Jornalismo",
  "Letras",
  "Linguística",
  "Marketing",
  "Matemática",
  "Medicina Veterinária",
  "Medicina",
  "Meteorologia",
  "Música",
  "Nutrição",
  "Obstetrícia",
  "Oceanografia",
  "Odontologia",
  "Pedagogia",
  "Produção Editorial",
  "Psicologia",
  "Publicidade e Propaganda",
  "Química",
  "Relações Internacionais",
  "Relações Públicas",
  "Sistemas de Informação",
  "Teatro",
  "Terapia Ocupacional",
  "Turismo",
  "Zootecnia",
]

courses.each do |course|
  Course.create!(name: course)
end

# Seed for a restricted number of courses
# courses_number = 10
# for i in 1..courses_number
#   Universitie.create(name: courses.sample)
# end

# Creating Resumes
User.all.where(undergraduate: true).each do |undergraduate|
  Resume.create!(
    user: undergraduate,
    university: University.order("RANDOM()").first,
    course: Course.order("RANDOM()").first,
    school_email: Faker::Internet.email,
    relative_completion: rand(0..100),
    academic_description: Faker::HitchhikersGuideToTheGalaxy.quote,
    stance: Resume::STANCE.sample)
end

# Creating Meetings
duration = [0.5, 1, 1.5, 2]
rating = [0, 1, 2, 3, 4, 5]

# Creating meeting by especifying the amount
meetings_number = 100
for i in 1..meetings_number
  randon_times = []
  randon_times << Faker::Time.forward(rand(8), :all) # random time in the next 7 days
  randon_times << Faker::Time.backward(rand(8), :all) # random time in the last 7 days
  start_time = randon_times.sample

  Meeting.create!(
    start_time: start_time,
    end_time: start_time + duration.sample.hour,
    review_title: Faker::MostInterestingManInTheWorld.quote,
    review_content: Faker::Hacker.say_something_smart,
    rating: rating.sample,
    undergraduate: User.where(undergraduate: true).order("RANDOM()").first,
    highschooler: User.where(undergraduate: false).order("RANDOM()").first
    )
end

# Creating meeting for all undergraduates
User.all.where(undergraduate: true).each do |undergraduate|
  randon_times = []
  randon_times << Faker::Time.forward(rand(8), :all) # mettings to occur in the next 7 days
  randon_times << Faker::Time.backward(rand(8), :all) # mettings that have already occurred in the last 7 days
  start_time = randon_times.sample

  Meeting.create!(
    start_time: start_time,
    end_time: start_time + duration.sample.hour,
    review_title: Faker::MostInterestingManInTheWorld.quote,
    review_content: Faker::Hacker.say_something_smart,
    rating: rating.sample,
    undergraduate: undergraduate,
    highschooler: User.where(undergraduate: false).order("RANDOM()").first
    )
end
