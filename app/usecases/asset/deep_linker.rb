class Asset::DeepLinker

  attr_reader :scope
  private     :scope

  def initialize(scope)
    @scope = scope
  end

  def link(list, tree_params)
    deep_link(list, nil, tree_params)
  end

  private

    def deep_link(list, root, tree_params = {})
      Array.wrap(tree_params).each_with_index do |asset_aggregate, idx|
        asset = scope.assets.find(asset_aggregate["item"]["id"])
        asset.position = idx
        asset.asset = root
        asset.list = list
        asset.save!
        if asset_aggregate["children"].present?
          deep_link(list, asset, Array.wrap(asset_aggregate["children"]))
        end
      end
    end

end