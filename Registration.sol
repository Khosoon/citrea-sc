// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExamRegistration {
    struct Student {
        string name;
        uint256 registrationTime;
        bool isRegistered;
    }
    
    address public admin;
    uint256 public currentStudentCount;
    
    mapping(address => Student) public students;
    address[] public registeredStudents;
    
    event StudentRegistered(address indexed studentAddress, string name, uint256 timestamp);
    event RegistrationCancelled(address indexed studentAddress);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    constructor(
    ) {
        admin = msg.sender;
    }
    
    function registerForExam(string memory _name, address studentAddress) external  {
        require(!students[studentAddress].isRegistered, "Already registered");
        
        students[studentAddress] = Student({
            name: _name,
            registrationTime: block.timestamp,
            isRegistered: true
        });   
        registeredStudents.push(studentAddress);
        currentStudentCount++;
        
    }
    

    function getRegisteredStudents() external onlyAdmin view returns (address[] memory) {
        return registeredStudents;
    }
    
    function getStudentDetails(address studentAddress) 
        external 
        view 
        returns (
            string memory name,
            uint256 registrationTime,
            bool isRegistered
        ) 
    {
        Student memory student = students[studentAddress];
        return (
            student.name,
            student.registrationTime,
            student.isRegistered
        );
    }
}
