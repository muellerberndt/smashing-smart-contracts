contract Assertions {
    
    function assertion1(uint256 input) {
        assert(input * 4 < 1024);
    }
    
    function assertion2(uint256 input) {
        if (input > 256) {
            throw;
        }
        
        assert(input * 4 <= 1024);  
    }
    
}