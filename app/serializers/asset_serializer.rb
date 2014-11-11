class AssetSerializer < ActiveModel::Serializer

  attributes :created_at, :name, :file, :tag_list

  has_many :assets

  # these should be belongs_to but doesn't wotk with ActiveModel::Serializer
  # causes undefined method error
  has_one :band

end