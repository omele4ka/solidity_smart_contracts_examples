/* разработать смарт-контракт для управления курсами и учетом
студентов в учебном центре. Контракт должен обеспечивать добавление новых
курсов, регистрацию студентов на курсы и отслеживание их успеваемости. */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract EducationalCenter {
    struct Course {
        string courseName;
        address teacher;
        address[] students;
        mapping (address => uint) grades;
    }

    struct Student {
        string studentName;
        string[] coursesEnrolled;
        mapping (string => uint) grades;
    }

    mapping(string => Course) private courses;
    mapping(address => Student) private students;

    function addCourse(string memory courseName, address teacher) public {
        require(courses[courseName].teacher == address(0), "Course already exists");
        courses[courseName].courseName = courseName;
        courses[courseName].teacher = teacher;
    }

    function registerStudent(string memory studentName) public {
        require(bytes(students[msg.sender].studentName).length == 0, "Student already exists");
        students[msg.sender].studentName = studentName;
    }

    function enrollStudentToCourse(string memory courseName) public {
        require(bytes(students[msg.sender].studentName).length != 0, "Student does not exist");
        require(courses[courseName].teacher != address(0), "Course does not exist");
        students[msg.sender].coursesEnrolled.push(courseName);
        courses[courseName].students.push(msg.sender);
    }

    function assignGrade(address studentAddress, string memory courseName, uint grade) public {
        require(courses[courseName].teacher == msg.sender, "Only a teacher can assign a grade");
        require(bytes(students[studentAddress].studentName).length != 0, "Student does not exist");

        students[studentAddress].grades[courseName] = grade;
        courses[courseName].grades[studentAddress] = grade;
    }

    function getStudentCourses(address studentAddress) public view returns (string[] memory) {
        require(bytes(students[studentAddress].studentName).length != 0, "Student does not exist");
        return students[studentAddress].coursesEnrolled;
    }

    function getCourseStudents(string memory courseName) public view returns (address[] memory) {
        require(courses[courseName].teacher != address(0), "Course does not exist");
        return courses[courseName].students;
    }

    function getGrade(address studentAddress, string memory courseName) public view returns (uint) {
        require(courses[courseName].teacher != address(0), "Course does not exist");
        require(bytes(students[studentAddress].studentName).length != 0, "Student does not exist");
        return students[studentAddress].grades[courseName];
    }
}