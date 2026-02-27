CREATE DATABASE myanmar_student_mobility;
USE myanmar_student_mobility;
CREATE TABLE survey_responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    response_time DATETIME,
    gender ENUM('Male','Female') NOT NULL,
    return_plan ENUM('Yes','No','Not Sure') NOT NULL,
    reason VARCHAR(255)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/survey_data.csv'
INTO TABLE survey_responses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@response_time, gender, return_plan, reason)
SET response_time = STR_TO_DATE(@response_time, '%Y/%m/%d %h:%i:%s %p GMT+7');

SELECT COUNT(*) AS total_responses
FROM survey_responses;

-- overall return distribution
SELECT return_plan, COUNT(*) AS count
FROM survey_responses
GROUP BY return_plan;

-- retrun plan by gender
SELECT gender, return_plan, COUNT(*) AS count
FROM survey_responses
GROUP BY gender, return_plan
ORDER BY gender;

-- most common reasons
SELECT reason, COUNT(*) AS count
FROM survey_responses
WHERE return_plan IN ('No','Not Sure')
GROUP BY reason
ORDER BY count DESC;

