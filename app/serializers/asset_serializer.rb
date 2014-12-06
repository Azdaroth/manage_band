class AssetSerializer < ActiveModel::Serializer

  delegate :id, :name, :tag_list, to: :object

  attributes :item, :children

  has_many :assets

  def item
    {
      id: id,
      name: name,
      file_url: file_url,
      tag_list: tag_list
    }
  end

  def children
    assets
  end

  def file_url
    ENV["HOST"] + object.attachment.file.url
  end


end