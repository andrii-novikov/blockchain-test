namespace :reset do
  desc 'Destroy all blocks and transactions'
  task state: :environment do
    Block.destroy_all
    Transaction.destroy_all
  end

  desc 'Destroy all nodes'
  task nodes: :environment do
    Node.destroy_all
  end
end