class AssetListSerializer < ActiveModel::Serializer

  attributes :created_at, :id, :name, :tag_list, :assets_without_parent

  has_many :assets

  def assets_without_parent
    object.assets_without_parent.map { |asset| AssetSerializer.new(asset, root: false) }
  end

end