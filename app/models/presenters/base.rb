module Presenters
  class Base < Frosting::BasePresenter
    def self.presents *components
      components.each do |component|
        define_method(component) do
          present super()
        end
      end
    end

    def self.presents_collections *collections
      collections.each do |collection|
        define_method(collection) do
          present_collection super()
        end
      end
    end
  end
end
