class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image
  set_id { 'null' }
  set_type :image
end
