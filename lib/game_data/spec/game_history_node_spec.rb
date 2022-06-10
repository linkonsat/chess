require '../game_history_node'
describe Node do
    describe '#delete_next_node' do 
    subject(:node) { described_class.new }
    it 'Deletes the next node.' do
        node.next_node = 5
        node.delete_next_node
        expect(node.next_node).to eql(nil)
    end
end
end