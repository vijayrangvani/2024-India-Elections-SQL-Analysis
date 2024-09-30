# Business Questions - 2024 India Elections SQL Analysis 🗳️🇮🇳

This document outlines the key business questions addressed in the **2024 India Elections SQL Analysis** project. Each question is answered using specific SQL queries provided in the main SQL file.

---

### 1. **What is the total number of seats available for elections?**

- **Objective**: Determine the overall number of seats available for the elections.
- **SQL Query**:

    ```sql
    SELECT DISTINCT COUNT(Parliament_Constituency) AS [Total Seats]
    FROM constituencywise_results;
    ```

---

### 2. **What is the total number of seats available for elections in each state?**

- **Objective**: Calculate the total number of seats available in each state for the elections.
- **SQL Query**:

    ```sql
    SELECT s.State, COUNT(DISTINCT Parliament_Constituency) AS [Total Seats Statewise]
    FROM statewise_results sr 
    JOIN states s ON sr.State_ID = s.State_ID
    GROUP BY s.State;
    ```

---

### 3. **How many total seats were won by the NDA alliance?**

- **Objective**: Identify the total number of seats won by the NDA alliance.
- **SQL Query**:

    ```sql
    SELECT SUM(
        CASE WHEN party IN (
            'Bharatiya Janata Party - BJP', 
            'Telugu Desam - TDP', 
            'Janata Dal (United) - JD(U)',
            'Shiv Sena - SHS', 
            'AJSU Party - AJSUP', 
            'Apna Dal (Soneylal) - ADAL', 
            'Asom Gana Parishad - AGP',
            'Hindustani Awam Morcha (Secular) - HAMS', 
            'Janasena Party - JnP', 
            'Janata Dal (Secular) - JD(S)',
            'Lok Janshakti Party (Ram Vilas) - LJPRV', 
            'Nationalist Congress Party - NCP',
            'Rashtriya Lok Dal - RLD', 
            'Sikkim Krantikari Morcha - SKM'
        ) THEN [Won] ELSE 0 END) AS [Total Seats Won by NDA]
    FROM partywise_results;
    ```

---

### 4. **Which parties in the NDA alliance won the most seats?**

- **Objective**: Determine which parties in the NDA alliance secured the highest number of seats.
- **SQL Query**:

    ```sql
    SELECT Party AS [Party Name], Won AS [Total Seats Won]
    FROM partywise_results
    WHERE party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
        'Janata Dal (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
        'Janata Dal (Secular) - JD(S)',
        'Lok Janshakti Party (Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM')
    ORDER BY Won DESC;
    ```

---

### 5. **How many total seats were won by the I.N.D.I.A alliance?**

- **Objective**: Identify the total number of seats won by the I.N.D.I.A alliance.
- **SQL Query**:

    ```sql
    SELECT SUM(
        CASE WHEN party IN (
            'Indian National Congress - INC',
            'Aam Aadmi Party - AAAP',
            'All India Trinamool Congress - AITC',
            'Bharat Adivasi Party - BHRTADVSIP',
            'Communist Party of India (Marxist) - CPI(M)',
            'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
            'Communist Party of India - CPI',
            'Dravida Munnetra Kazhagam - DMK',
            'Indian Union Muslim League - IUML',
            'Jammu & Kashmir National Conference - JKN',
            'Jharkhand Mukti Morcha - JMM',
            'Kerala Congress - KEC',
            'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
            'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
            'Rashtriya Janata Dal - RJD',
            'Rashtriya Loktantrik Party - RLTP',
            'Revolutionary Socialist Party - RSP',
            'Samajwadi Party - SP',
            'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
            'Viduthalai Chiruthaigal Katchi - VCK'
        ) THEN [won] ELSE 0 END
    ) AS [Total Seats Won by I.N.D.I.A Alliance]
    FROM partywise_results;
    ```

---

### 6. **Which parties in the I.N.D.I.A alliance won the most seats?**

- **Objective**: Determine which parties in the I.N.D.I.A alliance secured the highest number of seats.
- **SQL Query**:

    ```sql
    SELECT Party AS [Party Name], Won AS [Total Seats Won]
    FROM partywise_results
    WHERE party IN (
        'Indian National Congress - INC',
        'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India (Marxist) - CPI(M)',
        'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Jharkhand Mukti Morcha - JMM',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK')
    ORDER BY [Total Seats Won] DESC;
    ```

---

### 7. **How can we classify parties into their respective alliances (NDA, I.N.D.I.A, OTHER)?**

- **Objective**: Update the database to classify parties into their respective alliances for better analysis.
- **SQL Queries**:

    1. **Add New Column**: 
        ```sql
        ALTER TABLE partywise_results
        ADD party_allianz VARCHAR(50);
        ```

    2. **Update NDA Parties**: 
        ```sql
        UPDATE partywise_results
        SET party_allianz = 'NDA'
        WHERE party IN (
            'Bharatiya Janata Party - BJP',
            'Telugu Desam - TDP',
            'Janata Dal (United) - JD(U)',
            'Shiv Sena - SHS',
            'AJSU Party - AJSUP',
            'Apna Dal (Soneylal) - ADAL',
            'Asom Gana Parishad - AGP',
            'Hindustani Awam Morcha (Secular) - HAMS',
            'Janasena Party - JnP',
            'Janata Dal (Secular) - JD(S)',
            'Lok Janshakti Party (Ram Vilas) - LJPRV',
            'Nationalist Congress Party - NCP',
            'Rashtriya Lok Dal - RLD',
            'Sikkim Krantikari Morcha - SKM'
        );
        ```

    3. **Update I.N.D.I.A Parties**: 
        ```sql
        UPDATE partywise_results
        SET party_allianz = 'I.N.D.I.A'
        WHERE party IN (
            'Indian National Congress - INC',
            'Aam Aadmi Party - AAAP',
            'All India Trinamool Congress - AITC',
            'Bharat Adivasi Party - BHRTADVSIP',
            'Communist Party of India (Marxist) - CPI(M)',
            'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
            'Communist Party of India - CPI',
            'Dravida Munnetra Kazhagam - DMK',
            'Indian Union Muslim League - IUML',
            'Jammu & Kashmir National Conference - JKN',
            'Jharkhand Mukti Morcha - JMM',
            'Kerala Congress - KEC',
            'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
            'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
            'Rashtriya Janata Dal - RJD',
            'Rashtriya Loktantrik Party - RLTP',
            'Revolutionary Socialist Party - RSP',
            'Samajwadi Party - SP',
            'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
            'Viduthalai Chiruthaigal Katchi - VCK'
        );
        ```

    4. **Update OTHER Parties**: 
        ```sql
        UPDATE partywise_results
        SET party_allianz = 'OTHER'
        WHERE party NOT IN (
            'Bharatiya Janata Party - BJP',
            'Telugu Desam - TDP',
            'Janata Dal (United) - JD(U)',
            'Shiv Sena - SHS',
            'AJSU Party - AJSUP',
            'Apna Dal (Soneylal) - ADAL',
            'Asom Gana Parishad - AGP',
            'Hindustani Awam Morcha (Secular) - HAMS',
            'Janasena Party - JnP',
            'Janata Dal (Secular) - JD(S)',
            'Lok Janshakti Party (Ram Vilas) - LJPRV',
            'Nationalist Congress Party - NCP',
            'Rashtriya Lok Dal - RLD',
            'Sikkim Krantikari Morcha - SKM',
            'Indian National Congress - INC',
            'Aam Aadmi Party - AAAP',
            'All India Trinamool Congress - AITC',
            'Bharat Adivasi Party - BHRTADVSIP',
            'Communist Party of India (Marxist) - CPI(M)',
            'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
            'Communist Party of India - CPI',
            'Dravida Munnetra Kazhagam - DMK',
            'Indian Union Muslim League - IUML',
            'Jammu & Kashmir National Conference - JKN',
            'Jharkhand Mukti Morcha - JMM',
            'Kerala Congress - KEC',
            'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
            'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
            'Rashtriya Janata Dal - RJD',
            'Rashtriya Loktantrik Party - RLTP',
            'Revolutionary Socialist Party - RSP',
            'Samajwadi Party - SP',
            'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
            'Viduthalai Chiruthaigal Katchi - VCK'
        );
        ```

---

This concludes the list of business questions and their respective SQL queries for the 2024 India Elections SQL Analysis project.
