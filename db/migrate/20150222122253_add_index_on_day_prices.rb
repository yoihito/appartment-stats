class AddIndexOnDayPrices < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE INDEX index_prices_on_date_trunc_day
      ON prices(date_trunc('day',prices.created_at));
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX index_prices_on_date_trunc_day
    SQL
  end
end
