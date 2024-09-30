-- 1. Total Seats

select 
Distinct count(Parliament_Constituency) as [Total Seats]
from constituencywise_results;

-- 2.What is the total number of seats available for elections in each state

Select  s.State, count(Distinct Parliament_Constituency) as [Total Seats Statewise]
from statewise_results sr 
join states s on sr.State_ID = s.State_ID
group by s.State;

-- 3. Total Seats Won by NDA Allianz

select 
sum (
	case when party in (
				'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
		)
		Then [Won]
		Else 0
		END)as [Total Seats Won by NDA]
From partywise_results;

-- 4. Seats Won by NDA Allianz Parties

Select Party as [Party Name], Won as [Total Seats Won]
from partywise_results
where party in (
				'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
order by Won Desc;

-- 5.Total Seats Won by I.N.D.I.A. Allianz

select 
sum (
	 Case when party in (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
			Then [won] 
			Else 0
			End
) AS [Total Seats Won by I.N.D.I.A Alliance]
from partywise_results;

-- 6. Seats Won by I.N.D.I.A. Allianz Parties

select Party as [Party Name], Won as [Total Seats Won]
from partywise_results
where party in (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
Order by [Total Seats Won] Desc;

-- 7.Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

 alter table partywise_results
 add party_allianz varchar(50);

update partywise_results
set party_allianz = 'NDA'
where party in 
(
	'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

update partywise_results
set party_allianz = 'I.N.D.I.A'
where party in 
(
	 'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
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


update partywise_results
set party_allianz = 'OTHER'
where party_allianz is NULL;

-- 8. Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select party_allianz,sum(won) as [Total Seats Won]
from partywise_results
group by party_allianz
order by  [Total Seats Won] desc;

-- 9. Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

select Winning_Candidate as [candidate],p.Party,party_allianz ,Total_Votes,cr.margin , Constituency_Name, s.state 
from constituencywise_results cr
join partywise_results as p on cr.Party_ID = p.Party_ID
join statewise_results sr on sr.Parliament_Constituency =cr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
WHERE s.State = 'Uttar Pradesh' AND cr.Constituency_Name = 'AMETHI';

-- 10 . What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

select 
		cd.Candidate,
		cd.party,
		cd.EVM_Votes,Postal_Votes,
		cd.Total_votes,
		cr.Constituency_Name
from constituencywise_details cd
join constituencywise_results cr on cr.Constituency_ID = cd.Constituency_ID
where cr.Constituency_Name = 'Mathura'
order by cd.Total_votes desc;

-- 11. Which parties won the most seats in s State, and how many seats did each party win?

select pr.party,count(Constituency_ID) as [Seats Won]
from constituencywise_results cr
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join partywise_results pr on cr.Party_ID = pr.Party_ID
where state = 'Andhra Pradesh'
group by party
Order by [Seats Won] Desc;

-- 12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

select s.State, 
Count(Case when party_allianz ='NDA' Then 1 END) as 'NDA',
Count(Case when party_allianz ='I.N.D.I.A' Then 1 END) as 'I.N.D.I.A',
Count(Case when party_allianz ='OTHER' Then 1 END) as 'OTHER'
from statewise_results sr 
join constituencywise_results cr on sr.Parliament_Constituency = cr.Parliament_Constituency
join partywise_results pr on cr.Party_ID = pr.Party_ID
join states s on s.State_ID = sr.State_ID
Group by s.State
Order by s.State;

-- 13. Which candidate received the highest number of EVM votes in each constituency (Top 10)?

select *
from constituencywise_results cr
join constituencywise_details cd on cr.Constituency_ID = cr.Constituency_ID
Order by EVM_Votes desc