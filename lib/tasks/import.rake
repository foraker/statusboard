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

  task pivotal_update: :environment do
    interval = 15.minutes.ago
    ActivePivot::Importer.run(interval)
  end

  task pivotal_initial: :environment do
    interval = 3.years.ago
    ActivePivot::Importer.run(interval)
  end
end
