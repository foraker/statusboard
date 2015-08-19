module Refinements
  module BusinessDay
    refine Date do
      def business_day?
        !(saturday? || sunday?)
      end
    end
  end
end
