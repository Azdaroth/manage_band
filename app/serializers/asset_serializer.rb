class AssetSerializer < ActiveModel::Serializer

  delegate :id, :name, :tag_list, to: :object

  attributes :item, :children

  def item
    {
      id: id,
      name: name,
      file_url: file_url,
      tag_list: tag_list
    }
  end

  def children
    object.assets.map { |asset| AssetSerializer.new(asset, root: false) }
  end

  def file_url
    if object.attachment
      ENV["HOST"] + object.attachment.file.url
    end
  end


end