global LASI "path" 
global LASI-CORE "path"
global DAD "path"
global folder "path"
cd "$folder"

clear
set maxvar 30000

/***********************************************************************************
Section 1: Harmonized LASI Vars
************************************************************************************/

	use "/path/H_LASI_a2.dta", clear
	
	* living arrangement	   
	   gen livealone1 = .
	   replace livealone1 = 1 if r1lvwith==1 /* live alone */
	   replace livealone1 = 0 if inlist(r1lvwith, 2, 3, 4, 5)

	* currently in paid work
	   gen cpaywork1 = .
	   replace cpaywork1 = 0 if r1work == 0
	   replace cpaywork1 = 1 if r1work == 1

	* weekly contact with friend in person
	   gen contfrienip1 = .
	   replace contfrienip1 = 1 if r1fcntf==1
	   replace contfrienip1 = 0 if r1fcntf==0

	* weekly contact with friend by phone or mail
	   gen contfrienpm1 = .
	   replace contfrienpm1 = 1 if r1fcntpm==1
	   replace contfrienpm1 = 0 if r1fcntpm==0

	* weekly contact with friend in-person/phone/mail
	   gen  contfriena1 = .
	   replace contfriena1 = 1 if r1fcnt==1
	   replace contfriena1 = 0 if r1fcnt==0

	*  current job occupation
	   gen coccup = .
	   replace coccup = 1 if r1jcocc_l == 1
	   replace coccup = 2 if r1jcocc_l == 2
	   replace coccup = 3 if r1jcocc_l == 3
	   replace coccup = 4 if r1jcocc_l == 4
	   replace coccup = 5 if r1jcocc_l == 5
	   replace coccup = 6 if r1jcocc_l == 6
	   replace coccup = 7 if r1jcocc_l == 7
	   replace coccup = 8 if r1jcocc_l == 8
	   replace coccup = 9 if r1jcocc_l == 9
	   replace coccup = 10 if r1jcocc_l == 10
	   replace coccup = 11 if r1jcocc_l == 11

	   
	* age n=72,262 mean=57.93 std=11.69 min=18 max=116
	* gender; Dis 1=30,577 0=41,685
	   rename r1agey age1
	   gen agesqr = age * age
	   gen male =.
	   replace male = 1 if ragender == 1
	   replace male = 0 if ragender == 2
	 * marital status
	   gen mastat1 = .
	   replace mastat1 = 1 if inlist(r1mstat, 1, 3)
	   replace mastat1 = 2 if r1mstat == 8
	   replace mastat1 = 3 if r1mstat == 7
	   replace mastat1 = 4 if inlist(r1mstat, 4, 5)


	 * religion 0-4; Dis 0=145 1=52,983 2=8,668 3=7216 4=3246
	   gen religion1 = .
	   replace religion1 = 0 if r1relig_l == 1 /*none*/
	   replace religion1 = 1 if r1relig_l == 2 /*hindu*/
	   replace religion1 = 2 if r1relig_l == 3 /*muslim*/
	   replace religion1 = 3 if r1relig_l == 4 /*christian*/
	   replace religion1 = 4 if inlist(r1relig_l, 5,6,7,8,9,10) /*others*/

	 * caste 0-3; Dis 0=19878 1=11995 2=12632 3=27186
	   gen caste1 = .
	   replace caste1 = 0 if r1caste == 4 /*none or other*/
	   replace caste1 = 1 if r1caste == 1 /*scheduled caste*/
	   replace caste1 = 2 if r1caste == 2 /*scheduled tribe*/
	   replace caste1 = 3 if r1caste == 3 /*other backward class(obc)*/

	 * indian state of resident; urban/rural;
	   rename hh1state state1  
	   rename hh1rural rural1
	 * household per capita consumption
	   xtile hhpcconsum = hh1cperc, nq(5)
	 * literacy; Dis 0=34160 1=38090
	   gen literacy = .
	   replace literacy = 0 if raliterate == 0
	   replace literacy =1 if raliterate==1

	 * childhood health 1-5; Dis 1=33697 2=30146 3=6978 4=1008 5=114 .=319
	   gen childhl= .
	   replace childhl = 1 if rachshlta == 1
       replace childhl = 2 if rachshlta == 2
       replace childhl = 3 if rachshlta == 3
       replace childhl = 4 if rachshlta == 4
       replace childhl = 5 if rachshlta == 5

	 * Childhood financial situation
	   gen chfiance = .
	   replace chfiance = 1 if rafinanch == 1
	   replace chfiance = 2 if rafinanch == 2
	   replace chfiance = 3 if rafinanch == 3

	 * height to cm
	   gen height1=r1mheight*100
	   
	 * country of birth; Dis 1=71340 0=907
	   gen bcountry = .
	   replace bcountry = 1 if rabcountry == 78
	   else replace bcountry = 0 if rabcountry >= 1 & rabcountry <= 186 & rabcountry != 78

	 * Depression
	   gen depress1 = .
	   replace depress1 = 0 if r1cidimde3 == 0 
	   replace depress1 = 1 if r1cidimde3 == 1

	 * difficulties with activities of daily living 
	   gen adltot1 = .
	   replace adltot1 = 1 if r1adltota_l == 1
	   replace adltot1 = 0 if r1adltota_l == 0

	 * hypertension
	   gen hibpe1 = .
	   replace hibpe1 = 0 if r1hibpe == 0 
	   replace hibpe1 = 1 if r1hibpe == 1 

	 * chronic heart disease
	   gen hearte1 = .
	   replace hearte1 = 0 if r1hearte == 0 
	   replace hearte1 = 1 if r1hearte == 1 

	 * stroke
	   gen stroke1 = .
	   replace stroke1 = 0 if r1stroke == 0 
	   replace stroke1 = 1 if r1stroke == 1 

	 * lung
	   gen lunge1 = .
	   replace lunge1 = 0 if r1lunge == 0 
	   replace lunge1 = 1 if r1lunge == 1 

	 * diabetes
	   gen diabe1 = .
	   replace diabe1 = 0 if r1diabe == 0 
	   replace diabe1 = 1 if r1diabe == 1   

	 * cancer
	   gen cancre1 = .
	   replace cancre1 = 0 if r1cancre == 0 
	   replace cancre1 = 1 if r1cancre == 1  

	 * arthritis
	   gen arthre1 = .
	   replace arthre1 = 0 if r1arthre == 0 
	   replace arthre1 = 1 if r1arthre == 1

	 * osteoporosis
	   gen osteoe1 = .
	   replace osteoe1 = 0 if r1osteoe == 0 
	   replace osteoe1 = 1 if r1osteoe == 1

	 * joint and bone combined
	   gen jointbone1 = .
	   replace jointbone1 = 0 if osteoe1 == 0 | arthre1== 0
	   replace jointbone1 = 1 if osteoe1 == 1 | arthre1== 1
	   replace jointbone1 = 2 if osteoe1 == 2 | arthre1== 2
	 * neuro/ psychiatric
	   gen psyche1 = .
	   replace psyche1 = 0 if r1psyche == 0 
	   replace psyche1 = 1 if r1psyche == 1

	  * cholesterol
	   gen hchole1 = .
	   replace hchole1 = 0 if r1hchole == 0 
	   replace hchole1 = 1 if r1hchole == 1
	  
	  save "$folder/LASI_H_062325", replace
	  
/***********************************************************************************
Section 2: LASI-Core Vars
************************************************************************************/
 
   use "/path/lasi_w1b_ind_bm.dta", clear
 
   * Point: play card / indoor games
      gen game = .
	  replace game = 1 if inlist(fs506, 6, 7) /* rarely/once a year/never */
	  replace game = 0 if inlist(fs506, 1, 2, 3, 4, 5)
	  
   * Point: visit relatives/friend
      gen visitrf = .
	  replace visitrf = 1 if inlist(fs508, 6, 7) /* rarely/once a year/never */
	  replace visitrf = 0 if inlist(fs508, 1, 2, 3, 4, 5)

   * Point: visit Attend religious functions /events
      gen areligion = .
	  replace areligion = 1 if inlist(fs510, 6, 7) /* rarely/once a year/never */
	  replace areligion = 0 if inlist(fs510, 1, 2, 3, 4, 5)

   * Point: visit Attend political/community/organization group meetings
      gen apcoevent = .
	  replace apcoevent = 1 if inlist(fs511, 6, 7) /* rarely/once a year/never */
	  replace apcoevent = 0 if inlist(fs511, 1, 2, 3, 4, 5)
	  
   * SUM Social activities domains
	 egen sum_domain4 = rowtotal(game visitrf areligion apcoevent)
	  
   * members of social association
	  gen memgroups1 = .
	  replace memgroups1 = 0 if fs501 == 2
	  replace memgroups1 = 1 if fs501 == 1

   * # of Other language speak
	  gen otherlang = .
	  replace otherlang = 0 if dm015s21 == 1
	  egen sum_otherlan = rowtotal(dm015s1 dm015s2 dm015s3 dm015s4 dm015s5 dm015s6 dm015s7 dm015s8 dm015s9 dm015s10 dm015s11 dm015s12 dm015s13 dm015s14 dm015s15 dm015s16 dm015s17 dm015s18 dm015s19 dm015s20)
	  replace otherlang = sum_otherlan if dm015s21 != 1 & !missing(dm015s1, dm015s2, dm015s3, dm015s4, dm015s5, dm015s6, dm015s7, dm015s8, dm015s9, dm015s10, dm015s11, dm015s12, dm015s13, dm015s14, dm015s15, dm015s16, dm015s17, dm015s18, dm015s19, dm015s20)

  * Point: Have friend? How often do you meet up with friends or contact friends via phone or email
      gen hclofri1 = .
	  replace hclofri1 = 0 if fs324 == 2
	  replace hclofri1 = 1 if fs324 == 1
	  
      gen mcfri = .
      replace mcfri = 1 if inlist(fs326, 4, 5) | inlist(fs327, 4, 5)  // At least once a year or never, either - 1
      replace mcfri = 0 if inlist(fs326, 1, 2, 3) & inlist(fs327, 1, 2, 3)  // At least several times a year
	  
	  gen lessconfri = .
	  replace lessconfri = 1 if fs324 == 1 & mcfri == 1
	  replace lessconfri = 0 if fs324 == 1 & mcfri == 0
	  replace lessconfri = 2 if fs324 == 2

   * Living with spouse / father / mother
     gen lvwspouse = 0
	 replace lvwspouse = 1 if dm025_1 == 1 | dm025_2 == 1 | dm025_3 == 1 | dm025_4 == 1 | dm025_5 == 1 
	 replace lvwspouse = . if dm025_1 == . & dm025_2 == . & dm025_3 == . & dm025_4 == . & dm025_5 == .
	 
	 gen lvwfa = 0
	 replace lvwfa = 1 if fs301 == 1
	 replace lvwfa = . if fs301 == . 
	 
	 gen lvwma = 0
	 replace lvwma = 1 if fs310 == 1
	 replace lvwma = . if fs310 == . 
	  
   * # of close friend
	  rename fs325 numclofri
	  replace numclofri = . if inlist(numclofri, .r, .d)
  	  
	  
 * share personal matters
   ** whether share personal matters with any
	  gen shareany1 = .
	  replace shareany1 = 1 if fs328s16 == 0
	  replace shareany1 = 0 if fs328s16 == 1

   ** # of people they share
      gen numshare1 = .
	  replace numshare1 = 0 if fs328s16 == 1
	  egen sum_fs328s = rowtotal(fs328s1 fs328s2 fs328s3 fs328s4 fs328s5 fs328s6 fs328s7 fs328s8 fs328s9 fs328s10 fs328s11 fs328s12 fs328s13 fs328s14 fs328s15)
	  replace numshare1 = sum_fs328s if fs328s16 != 1 & !missing(fs328s1, fs328s2, fs328s3, fs328s4, fs328s5, fs328s6, fs328s7, fs328s8, fs328s9, fs328s10, fs328s11, fs328s12, fs328s13, fs328s14, fs328s15, fs328s16)
   *** whether share with father
      gen shwfathe1 = .
	  replace shwfathe1 = 0 if fs328s1 == 0
      replace shwfathe1 = 1 if fs328s1 == 1

   *** whether share with mother
      gen shwmothe1 = .
	  replace shwmothe1 = 0 if fs328s2 == 0
      replace shwmothe1 = 1 if fs328s2 == 1

   *** whether share with brother
      gen shwbrothe1 = .
	  replace shwbrothe1 = 0 if fs328s3 == 0
      replace shwbrothe1 = 1 if fs328s3 == 1

   *** whether share with sister
      gen shwsist1 = .
	  replace shwsist1 = 0 if fs328s4 == 0
      replace shwsist1 = 1 if fs328s4 == 1

   *** whether share with spouse
      gen shwspou1 = .
	  replace shwspou1 = 0 if fs328s5 == 0
      replace shwspou1 = 1 if fs328s5 == 1

   *** whether share with son
      gen shwson1 = .
	  replace shwson1 = 0 if fs328s6 == 0
      replace shwson1 = 1 if fs328s6 == 1

   *** whether share with daughter
      gen shwdau1 = .
	  replace shwdau1 = 0 if fs328s7 == 0
      replace shwdau1 = 1 if fs328s7 == 1

   *** whether share with son in law
      gen shwsonil1 = .
	  replace shwsonil1 = 0 if fs328s8 == 0
      replace shwsonil1 = 1 if fs328s8 == 1

   *** whether share with daughter in law
      gen shwdauil1 = .
	  replace shwdauil1 = 0 if fs328s9 == 0
      replace shwdauil1 = 1 if fs328s9 == 1

   *** whether share with grandchildren
      gen shwgrandch1 = .
	  replace shwgrandch1 = 0 if fs328s10 == 0
      replace shwgrandch1 = 1 if fs328s10 == 1

   *** whether share with grandparents
      gen shwgrandpar1 = .
	  replace shwgrandpar1 = 0 if fs328s11 == 0
      replace shwgrandpar1 = 1 if fs328s11 == 1

   *** whether share with parents in law
      gen shwparil1 = .
	  replace shwparil1 = 0 if fs328s12 == 0
      replace shwparil1 = 1 if fs328s12 == 1

   *** whether share with other relatives
      gen shworela1 = .
	  replace shworela1 = 0 if fs328s13 == 0
      replace shworela1 = 1 if fs328s13 == 1

   *** whether share with friend
      gen shwfr1 = .
	  replace shwfr1 = 0 if fs328s14 == 0
      replace shwfr1 = 1 if fs328s14 == 1

   *** whether share with other
      gen shwother1 = .
	  replace shwother1 = 0 if fs328s15 == 0
      replace shwother1 = 1 if fs328s15 == 1

  * fre attend religious activities
      gen reliactiv1 = .
	  replace reliactiv1 = 0 if fs510 == 7 /*never*/
	  replace reliactiv1 = 1 if fs510 == 1 /*daily*/
	  replace reliactiv1 = 2 if fs510 == 2 /*Several times a week*/
	  replace reliactiv1 = 3 if fs510 == 3 /*Once a week*/
	  replace reliactiv1 = 4 if fs510 == 4 /*Several times a month*/
	  replace reliactiv1 = 5 if fs510 == 5 /*At least once a month*/
	  replace reliactiv1 = 6 if fs510 == 6 /*Rarely/Once in a year*/

  * frequency of meeting with friends
      gen fmeetfri = .
  	  replace fmeetfri = 0 if fs326 == 1 /*daily*/
  	  replace fmeetfri = 1 if fs326 == 2 /*at least once in a week*/
	  replace fmeetfri = 2 if fs326 == 3 /*at least once in a month*/
	  replace fmeetfri = 3 if inlist(fs326, 4,5) /*at least once in a year/never*/

  * frequency of contact friends
      gen fcontfri = .
	  replace fcontfri = 0 if fs327 == 1 /*daily*/
	  replace fcontfri = 1 if fs327 == 2 /*at least once in a week*/
	  replace fcontfri = 2 if fs327 == 3/*at least once in a month*/
	  replace fcontfri = 3 if inlist(fs327, 4,5)/*at least once in a year/never*/

	
  * frequency of visit relatives/friend
     gen visitrf1 = .
     replace visitrf1 = 0 if inlist(fs508, 1,2) /*daily/Several times a week*/
     replace visitrf1 = 1 if inlist(fs508, 3,4) /*once a week/Several times a month*/
     replace visitrf1 = 2 if fs508 ==5 /*at least once a month*/
     replace visitrf1 = 3 if inlist(fs508, 6,7) /*rarely/never*/

	 save "$folder/LASI_C_062325", replace
	
********************************************************************************

		*merging 
		
		use "$folder/LASI_H_062325", clear
				
				merge 1:1 prim_key using "$folder/LASI_C_062325",    gen(mer1) /*n=1,146 unmatched*/
				merge 1:1 prim_key using "$folder/lasidad_educ_occup_vars_050724.dta",    gen(mer2)
                /*n=69,312 unmatched*/ 
				drop mer*  
		cou				
		save "$folder/LASI_HC_062325", replace /*tot=4,096*/
				
/***********************************************************************************
Section 3: create social isolation score - 2024 version (updated in section)
************************************************************************************/
	
	use "$folder/LASI_HC_062325", clear
  * Create Social Isolation Index Score (5 – point scale);
    gen particip = .
	replace particip = 1 if memgroups1 == 0
	replace particip = 0 if memgroups1 == 1
	
	gen withfri = .
	replace withfri = 3 if fmeetfri == 3 | fcontfri == 3 | visitrf1 == 3
	replace withfri = 2 if fmeetfri == 2 | fcontfri == 2 | visitrf1 == 2
	replace withfri = 1 if fmeetfri == 1 | fcontfri == 1 | visitrf1 == 1
	replace withfri = 0 if fmeetfri == 0 | fcontfri == 0 | visitrf1 == 0
	
	gen alone = .
	replace alone = 1 if livealone1 == 1
	replace alone = 0 if livealone1 == 0
	
    gen isoscore = .
	replace isoscore = 0 if livealone1 == 0 & withfri == 0 & particip == 0
	egen sum_score = rowtotal(alone withfri particip)
	replace isoscore = sum_score if !missing(alone, withfri, particip)
	
	drop particip withfri study sum_score alone
	
	label variable isoscore "social isolation index score (0-5)"
	
	save "$folder/LASI_HC_062325", replace
	
/***********************************************************************************
Section 4: Harmonized LASI-DAD
************************************************************************************/
	use "/path/h_dad_w1a3.dta", clear
	
	rename r1borient borient1
	rename r1bexefu bexefu1
	rename r1blangf blangf1
	rename r1bmemory bmemory1
	rename r1sgcp gcp1
	rename r1agey age_dad1
	rename raeduc_l educ_l
	rename r1wtresp wtresp1
	
	gen height_dad1 = r1mheight *100
	gen agesqr_dad1 = age_dad1*age_dad1
	gen educ_self = .
    replace educ_self = 1 if inlist(educ_l, 1, 2, 3, 4, 5, 6, 7, 8, 9)
    replace educ_self = 0 if educ_l == 0

	save "$folder/LASI_cog_062325", replace

********************************************************************************

		
		*merging 
		
		use "$folder/LASI_cog_062325", clear
				
				merge 1:1 prim_key using "$folder/LASI_HC_062325", keep(master match) nogenerate 
					
		save "$folder/LASI_062325", replace /*tot=4,096*/
	
				
/***********************************************************************************
Section 5: collapse var
************************************************************************************/

	use "$folder/LASI_062325", clear
	* marital status 
	gen cmastat1 = .
	replace cmastat1 = 1 if mastat1 == 1 //married & partner
	replace cmastat1 = 2 if inlist(mastat1, 2, 3, 4) // never/widowed/divorced/separated	
	
	* religion none/christian/others
	gen creligion1 = .
	replace creligion1 = 1 if religion1 == 1
	replace creligion1 = 2 if religion1 == 2
	replace creligion1 = 3 if inlist(religion1, 0, 3, 4)
	
	* fair/poor/very poor categories of childhood health status
	gen cchildhl = .
	replace cchildhl = 1 if childhl == 1
	replace cchildhl = 2 if childhl == 2
	replace cchildhl = 3 if inlist(childhl, 3, 4, 5)

	
	* education
	gen ceduc_l = .
	replace ceduc_l = 0 if educ_l == 0
	replace ceduc_l = 1 if educ_l == 1
	replace ceduc_l = 2 if educ_l == 2
	replace ceduc_l = 3 if educ_l == 3
	replace ceduc_l = 4 if educ_l == 4
	replace ceduc_l = 5 if educ_l == 5
	replace ceduc_l = 6 if inlist(educ_l, 6, 7, 8, 9)
	
	* attend religious activities
    gen creliactiv1 = .
	replace creliactiv1 = 0 if reliactiv1 == 0 
	replace creliactiv1 = 1 if inlist(reliactiv1, 1, 2) 
	replace creliactiv1 = 2 if inlist(reliactiv1, 3, 4) 
	replace creliactiv1 = 3 if reliactiv1 == 5 
	replace creliactiv1 = 4 if reliactiv1 == 6 
 
    * # of chronic conditions
    egen chronic_sum1 = rowtotal(hibpe1 diabe1 hearte1 stroke1 lunge1 cancre1 arthre1 osteoe1 psyche1 hchole1)
    * Replace chronic_sum with missing if all conditions are missing
    gen all_missing = (hibpe1 == . & diabe1 == . & hearte1 == . & stroke1 == . & lunge1 == . & cancre1 == . & arthre1 == . &  osteoe1 == . & psyche1 == . & hchole1 == .)
    replace chronic_sum1 = . if all_missing

	* categorize chronic conditions
	gen chronic1 = .
	replace chronic1 = 0 if chronic_sum1 == 0
	replace chronic1 = 1 if inlist(chronic_sum1, 1, 2)
	replace chronic1 = 2 if inlist(chronic_sum1, 3,4,5,6,7)
	
	drop all_missing
	
	save "$folder/LASI_col_062325", replace
	
/***********************************************************************************
Section 6 : updated social isolation index score USC
************************************************************************************/
	use "$folder/LASI_col_062325", clear
	
	* Point: respondent reports being married or having a partner but does not select the spouse/partner among the family members they have a close relationship with
	gen marblec = .
	replace marblec = 1 if cmastat1 == 1 & fs323s5 == 0
	replace marblec = 0 if cmastat1 == 1 & fs323s5 == 1
	replace marblec = 2 if cmastat1 == 2
	// 36 missing due to NMISS on question: close friend with partner/spouse 
	
	* Point: respondent lives with children but does not select the son/s, daughter/s, or daughter-in-law among the family members they have a close relationship with
	
	replace r1coresd = 0 if r1coresd == .k /* replace .k (no kid) as 0 (not living with children) to remain them in sample */
	
	gen lwchbng = .
	replace lwchbng = 0 if r1coresd == 1 & fs323s6 == 1 | fs323s7 == 1 | fs323s9 == 1
	replace lwchbng = 1 if r1coresd == 1 & fs323s6 == 0 & fs323s7 == 0 & fs323s9 == 0
	replace lwchbng = 2 if r1coresd == 0 & r1lvwith != .m
	replace lwchbng = 3 if r1coresd == 0 & fs323s16 == 1 & r1lvwith != .m
	replace lwchbng = 3 if r1lvwith == 2 & fs323s5 == 0 
	replace lwchbng = 4 if r1lvwith == 1 
	
    * Generate Social Isolation Index - updated
    gen score = game + visitrf + areligion + apcoevent + marblec + lwchbng + lessconfri

	summarize score, detail
	tab score, missing
 
	gen score_binary = .
	replace score_binary = 1 if score !=. &score >= 8
	replace score_binary = 0 if score !=. & score <= 7

	tab score_binary, missing /* 0 = 2,662; 1 = 1,323; . = 111 */
	
	save "$folder/LASI_complete_062325", replace


