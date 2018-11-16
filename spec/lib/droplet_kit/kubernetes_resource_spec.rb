require 'spec_helper'
require 'pry'

RSpec.describe DropletKit::KubernetesResource do
  subject(:resource) { described_class.new(connection: connection) }
  let(:kubernetes_node_pool_attributes) { DropletKit::KubernetesNodePool.new.attributes }
  include_context 'resources'

  describe "cluster_node_pools" do
    it 'returns the node_pools for a cluster' do
      cluster_id = 42
      stub_do_api("/v2/kubernetes/clusters/#{cluster_id}/node_pools", :get).to_return(body: api_fixture('kubernetes/cluster_node_pools'))
      node_pools= resource.cluster_node_pools(cluster_id: cluster_id)
      node_pools.each do |pool|
        expect(pool).to be_kind_of(DropletKit::KubernetesNodePool)
        expect(pool.attributes.keys).to eq kubernetes_node_pool_attributes.keys
      end
      binding.pry
      # TODO: check the items themselves
    end
  end
end
