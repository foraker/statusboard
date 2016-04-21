namespace :import do

  task twitter: :environment do
    Importers::TwitterImporter.new.import
  end

  task github: :environment do
    Importers::GithubImporter.new.import
  end

  task analytics: :environment do
    Importers::AnalyticsImporter.new.import
  end

  task code_climate: :environment do
    Importers::CodeClimateImporter.new.import
  end
end
