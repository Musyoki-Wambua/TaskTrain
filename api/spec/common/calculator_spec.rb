require_relative '../../app/models/calculator'
RSpec.describe "Calculator functionality" do 
    context 'numerical operations' do 
        it 'should add two numbers correctly' do 
            calc = Calculator.new(n1: 10, n2: 300)
            expect(calc.add).to eq(310)
        end
        it 'should square numbers correctly' do 
            calc = Calculator.new(n1: 1, n2: 1)
            calc = Calculator.new(n1: 2, n2: 1)
            calc = Calculator.new(n1: 6, n2: 1)
            expect(calc.square).to eq(310)
            expect(calc.add).to eq(310)
            expect(calc.add).to eq(310)
        end
        it 'should cube n1 correctly' do 
            
        end
    end
end