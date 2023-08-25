public class ternaryconditionsApexclass {
    
    public class inputParametersMethod{
        public String inputName;
        public Integer inputNumber;
        public Date inputDate;
    }
    public static void someMethod(){
        List<Opportunity> opp = new List<Opportunity>();
        for(Opportunity someList : [SELECT Id, IsDeleted, AccountId, Name, Description, StageName, Amount, Probability, Type, CloseDate FROM Opportunity]){
            someList.Name=(someList.StageName !='Closed Won' && someList.Amount==60000)?'subbareddy':'venkata';
            opp.add(someList);
        }
        Database.SaveResult[] sr = database.update(opp,false);
        for (Database.SaveResult srList : sr) {
            if(srList.isSuccess()){
                system.debug('success...');
            }else {
                system.debug('error');
            }
        }
    }
    public static void method2(){
        List<Case> cses = [select id, caseNumber, Status, Priority, Origin from Case];
        for(Case cs : cses){
            cs.Description = cs.Status=='New'?'Your case is New Status':cs.Priority=='High'?'your priority is high':cs.Origin=='Email'?'your case origin is email':'none';
        }
    }
    
    public static void caseInsertionMethod(Map<String, String> caseMap){
        List<Case> insertedCases = new List<Case>();
        String originValue =caseMap.get('originValue');
        String statusValue =caseMap.get('statusValue');
        String PriorityValue =caseMap.get('PriorityValue');
        for(Case cs : [select id, caseNumber, Status, Priority, Origin from Case]){
            cs.Origin = originValue;
            cs.Status = statusValue;
            cs.Priority = PriorityValue;
            insertedCases.add(cs);
        }
        update insertedCases;
    }
    //comment lines
    public static void performingInputParametersMethod(inputParametersMethod some1){ 
        system.debug('some-> ' + some1.inputName);
        system.debug('some-> ' + some1.inputNumber);
        system.debug('some-> ' + some1.inputDate);
    }
    
    public static void anotherCaseinsetion(Map<String, String> caseMap){
        String originValue = caseMap.get('originValue');
        String statusValue = caseMap.get('statusValue');
        String priorityValue = caseMap.get('priorityValue');
        List<Case> insertedCases = new List<Case>();
        for(integer i=0; i<=10;i++){
            case newCase = new Case();
            newCase.Origin = originValue;
            newCase.Status = statusValue;
            newCase.Priority = priorityValue;
            insertedCases.Add(newCase);
        }
        database.SaveResult[] sr = database.insert(insertedCases, false);
    }
    
    //above mthod only different way
    public static void differentWay(Map<String, String> caseMap){
        List<Case> insertedCases = new List<Case>();
        for(integer i=0; i<=10;i++){
            Case newCase = new Case(Origin = caseMap.get('originValue'), Status = caseMap.get('statusValue'), priority = caseMap.get('priorityValue'));
            insertedCases.Add(newCase);
        }
        if(!insertedCases.IsEmpty()){
            database.SaveResult[] sr = database.insert(insertedCases, false);
        }
    }
    
    // above one only for errorHandling
    public static void errorHandling(Map<String, String> caseMap){
        List<Case> insertedCases = new List<Case>();
        try{
            for(integer i=0; i<=10;i++){
                Case newCase = new Case(Origin = caseMap.get('originValue'), Status = caseMap.get('statusValue'), priority = caseMap.get('priorityValue'));
                insertedCases.Add(newCase);
            }
        } catch(exception e){
            system.debug('error is coming ');
        }
    }
    
    public static void examplesMethod(){
        List<Account> lstAccounts = [select id, Name, Rating, Industry from Account];
        Map<String, String> ratingMap = new Map<String, String>();
        Map<String, String> industrygMap = new Map<String, String>();
        for(Account acts : lstAccounts){
            ratingMap.Put('ratingValue', acts.Rating);
            industrygMap.Put('industryValue', acts.Industry);
        }
    }
    public static List<Contact> findoutContactEmail (String email){
        List<Contact> lstCons = [select id, FirstName, LastName, email from Contact where email =:email];
        if(!lstCons.IsEmpty()){
            return lstCons;
        }else return null;
    }
    
    public static void handlingErrorbefore(List<Account> accList){
        List<Account> accs = new List<Account>();
        for(Account acc : accList){
            if(acc.Rating == 'Hot'){
                acc.addError('account record rating not hot ');
            }
            else if(acc.Rating == 'Cold' && acc.Industry == 'Banking'){
                accs.Add(acc);
            }
        }
        if(!accs.IsEmpty()){
            insert accs;
        }
    }
    //anotherWay
    public static void anotherWay(List<Account> accList){
        List<Account> accs = new List<Account>();
        for(Account acc : accList){
            accs.Add(acc.Rating == 'Cold' && acc.Industry == 'Banking' ? acc : null);
            if(acc.Rating == 'Hot'){
                acc.addError('give alteranate rating value'); 
            }
        }
    }
    
    public class ContactWrapper{
        public Contact contacts {get;set;}
        public Boolean isSelected {get;set;}
    }
    
    public static void contactWrapperExample(){
        List<ContactWrapper> contactsWrpper = new List<ContactWrapper>();
        List<Contact> cons = [select id, email from Contact];
        for(Contact c : cons){
            ContactWrapper contactsWrpper1 = new ContactWrapper();
            contactsWrpper1.contacts = c;
            contactsWrpper1.isSelected = true;
            contactsWrpper.Add(contactsWrpper1);
            
        }
        system.debug('contactsWrpper' + contactsWrpper);
    }
    
    public static void exampleMethod1(){
        Map<String, Boolean> accountsData = new Map<String, Boolean>();
        List<Account> lstAccRec = [select Id, Name, Active__c from Account where Name='Sample Apex Account Record'];
        for(Account acc : lstAccRec){
            accountsData.put(acc.Name, acc.Active__c);  
        }
    }
    
    public static void accountRaingSetValue(List<Account> accList){
        List<Account> updatedList = new List<Account>();
        for(Account acc : accList){
            acc.Rating = acc.Industry == 'Banking' || acc.Industry == 'Healthcare' ?  'Hot' : null;
            updatedList.Add(acc);
        }
    }
    public static void createContactAndAccountWhenAccountNull(List<Contact> conList){
        List<Account> accs = new List<Account>();
        for(Contact con : conList){
            if(con.AccountId == null){
                Account acc = new Account();
                acc.Name = con.LastName;
                accs.Add(acc);
            }
        }
        if(!accs.IsEmpty()){
            insert accs;
        }
    }
    
    public static void createContactAndAccountWhenAccountNull1(List<Contact> consList){
        List<Account> accs = new List<Account>();
        for(Contact con : consList){
            Account acc = new Account();
            acc.Name = con.AccountId == null ? con.LastName : '';
            system.debug('acc.Name' + acc.Name);
            accs.add(acc);
        }
        if(!accs.IsEmpty()){
            system.debug('acc' + accs);
            insert accs;
        }
    }
    public static void anotherMethod2(List<Contact> conList){
        for(Contact con : conList){
            if(String.isBlank(con.Phone) && String.isBlank(con.Email)){
                con.phone.addError('phone values should enter must');
                con.email.addError('email should enter must');
            }
        }
    }
    
    public static void annualRevenueMethod(List<Account> accList){
        List<Account> insertionList = new List<Account>();
        for(Account acc : accList){
            acc.AnnualRevenue = acc.Industry == 'Banking' ? 200000 : acc.Industry == 'Finance' ? 30000 : acc.Industry == 'Healthcare' ? 40000 : 50000;
            insertionList.add(acc);
        }
        if(!insertionList.isEmpty()){
            insert insertionList;
        }
    }
    
    public static void contactCreationAccountIsMust(List<Contact> conList){
        for(Contact cons : conList){
            if(cons.AccountId == null){
                cons.addError('get create associated Account Record While Creating Contact Record'); 
            }
        }
    }
    
    public static void activeAccountsPrevents(){
        List<Account> accList = [select id, Name, Active__c from Account where Active__c = true];
        for(Account acc : accList){
            if(acc.Active__c == true){
                acc.addError('You are deleting active Account Record, so you could not able to delete active Account Record');
            }
        }
    }
    public static void preventDuplicateRecords(List<Account> accList){
        //List<Account> accs = [select id, name from Account];
        Map<String, Account> nameWithMap = new Map<String, Account>();
        for(Account ac : [select id, name from Account]){
            nameWithMap.put(ac.Name, ac);
        }
        for(Account acc : accList){
            if(nameWithMap.containskey(acc.Name)){
                acc.addError('duplicateRecord');
            }
        }
    }
    
    public static void preventAssociatedContatcsDeletion(List<Account> accList){
        Map<Id, Contact> accountIdMap = new Map<Id, Contact>(); 
        for(Contact con  : [select id, AccountId, lastName from Contact where AccountId!=null]){
            accountIdMap.Put(con.AccountId, con);
        }
        for(Account acc : accList){
            if(accountIdMap.ContainsKey(acc.Id)){
                acc.addError('you can not able to delete associated Contact Account Records');
            }
        }
    }
    /*public static void preventAssociatedContatcsDeletion1(List<Account> accountsToDelete){
set<Id> accountIds = new Set<Id>();
for(Account acId : accountsToDelete){
accountIds.add(acId.Id);
}
List<Contact> consList = [select id, AccountId, lastName from Contact where AccountId in :accountIds];
set<Id> accwithConId = new Set<Id>();
for(Contact cons : consList){
accwithConId.add(cons.AccountId);
}
for(Account sc : accountsToDelete){
if(accwithConId.Contains(sc.Id)){
sc.addError('can not able to delete');  
}
}
}*/
    public static void updatedPhoneandFaxMethod(List<Contact> conList){
        set<Id> accIds = new Set<Id>();
        for(Contact cons : conList){
            accIds.add(cons.AccountId);
        }
        Map<Id, Account> accWithMap = new Map<Id, Account>([select id, Name, Phone, Fax from Account  where Id In : accIds]);
        List<Contact> updatedContacts = new List<Contact>();
        for(Contact cons : conList){
            if(accWithMap.ContainsKey(cons.AccountId)){
                Account associatedValues = accWithMap.Get(cons.AccountId);
                cons.Phone = associatedValues.Phone;
                cons.Fax = associatedValues.Fax;
                updatedContacts.add(cons);
            }
        }
        if(!updatedContacts.IsEmpty()){
            update updatedContacts;
        }
    }
    
    public static void numberOfContactsCount(List<Contact> consList){
        set<String> accountId = new Set<String>();
        for(Contact con : consList){
            accountId.Add(con.AccountId);
        }
        List<Account> accounts = new List<Account>();
        for(AggregateResult aggresult : [select count(id) recordsCount, AccountId from Contact where AccountId IN : accountId group by AccountId]){
            id accId = (Id)aggresult.get('AccountId');
            integer count = (integer)aggresult.get('recordsCount');
            Account acc = new Account();
            acc.id = accId;
            acc.No_of_Contacts__c = count;
            accounts.add(acc);
        }
        if(!accounts.IsEmpty()){
            update accounts;
        }
    }
    
    public static void whileupdatingContactsCount(List<Contact> conList, Map<Id, Contact> oldMapContacts){
        Set<Id> accIds = new Set<Id>();
        for(Contact con : conList){
            accIds.add(con.AccountId);
            system.debug('accIds new ' + accIds);
        }
        for(Contact con : conList){
            system.debug('oldMapContacts.get(con.Id).AccountId ' + oldMapContacts.get(con.Id).AccountId);
            if(oldMapContacts.get(con.Id).AccountId !=con.AccountId){
                accIds.add(oldMapContacts.get(con.Id).AccountId);
                
            } 
            
        }
        system.debug('accIds old ' + accIds);
        List<Account> accounts = new List<Account>();
        List<AggregateResult> aggr =  [select count(id) recordsCount, AccountId from Contact where AccountId IN : accIds group by AccountId];
        for(AggregateResult aggresult :aggr){
            id accId = (Id)aggresult.get('AccountId');
            system.debug('accId' + accId);
            integer count = (integer)aggresult.get('recordsCount');
            Account acc = new Account();
            acc.id = accId;
            acc.No_of_Contacts__c = count;
            accounts.add(acc);
        }
        if(!accounts.IsEmpty()){
            update accounts;
        }
    }
    
    public static void updateAccountContactCount(Map<Id, Contact> newContacts, Map<Id, Contact> oldContacts) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        // Add AccountIds from new Contacts
        for (Contact newContact : newContacts.values()) {
            accountIdsToUpdate.add(newContact.AccountId);
        }
        // Add AccountIds from old Contacts where the AccountId changed
        for (Contact oldContact : oldContacts.values()) {
            if (oldContact.AccountId != newContacts.get(oldContact.Id).AccountId) {
                accountIdsToUpdate.add(oldContact.AccountId);
            }
        }
        if (!accountIdsToUpdate.isEmpty()) {
            List<Account> accountsToUpdate = new List<Account>();
            
            // Query for the contact counts per Account
            Map<Id, Integer> accountContactCounts = new Map<Id, Integer>();
            for (AggregateResult aggResult : [
                SELECT COUNT(Id) recordsCount, AccountId
                FROM Contact
                WHERE AccountId IN :accountIdsToUpdate
                GROUP BY AccountId
            ]) {
                Id accountId = (Id)aggResult.get('AccountId');
                Integer count = (Integer)aggResult.get('recordsCount');
                accountContactCounts.put(accountId, count);
            }
            // Update the Account records with the contact counts
            for (Id accId : accountIdsToUpdate) {
                if (accountContactCounts.containsKey(accId)) {
                    Account acc = new Account(Id = accId);
                    acc.No_of_Contacts__c = accountContactCounts.get(accId);
                    accountsToUpdate.add(acc);
                }
            }
            if (!accountsToUpdate.isEmpty()) {
                update accountsToUpdate;
            }
        }
    }
    public static void forDeletingUpdateContactsCount(List<Contact> oldContacts){
        Set<Id> accIds = new Set<Id>();
        for(Contact con : oldContacts){
            accIds.add(con.AccountId);
        }
        List<Account> updatedAccountList = new List<Account>();
        List<Account> accList = [select id, Name,(select id, AccountId from Contacts) from Account where Id IN :accIds];
        for(Account acccccc : accList){
            
            acccccc.No_of_Contacts__c = acccccc.Contacts.size();
            updatedAccountList.add(acccccc);
        }
        if(!updatedAccountList.IsEmpty()){
            update updatedAccountList;
        }
    }
    
    public static void someAnotherScenario(List<Account> accList){
        List<Contact> contactsList = new List<Contact>();
        for(Account acc : accList){
            if(acc.Create_Contact__c == true){
                
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.lastName = acc.Name;
                con.phone = acc.Phone;
                contactsList.add(con);
            }
        }
        if(!contactsList.IsEmpty()){
            insert contactsList;
        }
    }
    
    public static void someAnotherScenario1(List<Account> accList){
        List<Account> accountsList = new List<Account>();
        for(Account accs : accList){
            if(accs.Industry == 'Insurance' && accs.Industry !=''){
                accs.Rating = 'Hot';
                accountsList.add(accs);
            }
        }
        if(!accountsList.IsEmpty()){
            insert accountsList;
        }
    }
    
    public static void someAnotherScenario2(List<Opportunity> oppList){
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Opportunity opp: oppList){
            if(opp.Amount != null && opp.Amount > 10000){
                opp.Description = 'Requedt Opportunity is Hot Opportunity';
                opportunities.add(opp);
            }
        }
        if(!opportunities.IsEmpty()){
            insert opportunities;
        }
    }
    
    public static void someAnotherScenario3(List<Account> accList){
        List<Account> accounts = new List<Account>();
        for(Account acc : accList){
            if(acc.Active__c == true){
                acc.ShippingCity = acc.BillingCity;
                accounts.add(acc);
            }
        }
        if(!accounts.IsEmpty()){
            insert accounts;
        }
    }
    
    public static void latestCaseNumber(List<Case> caseList){
        List<Account> accList = new List<Account>();
        for(Case cs : caseList){
            if(cs.AccountId != null){
                Account acc = new Account();
                acc.Id = cs.AccountId;
                acc.Latest_Case_Number__c = cs.CaseNumber;
                accList.add(acc);
            }
        }
        if(!accList.IsEmpty()){
            update accList;
        }
    }
    
    public static void handleCases(List<Case> newCases, Map<Id, Case> oldCasesMap) {
        List<Id> accountIds = new List<Id>();
        Map<Id, String> latestCaseNumberMap = new Map<Id, String>();
        
        // Collect Account IDs and the latest Case Number for each related Case
        for (Case cs : newCases) {
            if (cs.AccountId != null) {
                accountIds.add(cs.AccountId);
                if (!latestCaseNumberMap.containsKey(cs.AccountId) ||
                    (oldCasesMap.containsKey(cs.Id) && cs.CreatedDate > oldCasesMap.get(cs.Id).CreatedDate)) {
                        latestCaseNumberMap.put(cs.AccountId, cs.CaseNumber);
                    }
            }
        }
        
        // Update the Latest_Case_Number__c field on related Account records
        List<Account> accListToUpdate = [SELECT Id FROM Account WHERE Id IN :accountIds];
        for (Account acc : accListToUpdate) {
            if (latestCaseNumberMap.containsKey(acc.Id)) {
                acc.Latest_Case_Number__c = latestCaseNumberMap.get(acc.Id);
            }
        }
        
        // Update the Account records
        if (!accListToUpdate.isEmpty()) {
            update accListToUpdate;
        }
    }
    public static void recentOpportunityAmount(List<Opportunity> oppList){
        set<String> accIds = new Set<String>();
        Map<Id, Decimal> oppWithMap = new Map<Id, Decimal>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null){
                accIds.add(opp.AccountId);
                system.debug('accIds' + accIds);
            //}
           // if(oppWithMap.containsKey(opp.AccountId)){
                oppWithMap.Put(opp.AccountId, opp.Amount); 
                system.debug('oppWithMap' + oppWithMap);
            }
        }
        List<Account> updatedAccounts = new List<Account>();
        List<Account> accounts = [select id, Name from Account where Id IN : oppWithMap.KeySet()];
        system.debug('accounts' + accounts);
        for(Account acc : accounts){
            Account ac = new Account(id=acc.id, Latest_Opportunity_Amount__c = oppWithMap.get(acc.id));
             
            system.debug('oppWithMap' + oppWithMap.get(acc.id));
            ac.Latest_Opportunity_Amount__c = oppWithMap.get(acc.id);
            updatedAccounts.add(ac);
        }
        if(!updatedAccounts.IsEmpty()){
            system.debug('updatedAccounts' + updatedAccounts);
            update updatedAccounts;
        }
    }
    
    public static void aacountsData (){
        List<Account> accounts = [select id, Name, Rating, Industry from Account];
        List<String> accName = new List<String>();
        Map<String, String> accountsWithMap = new Map<String, String>();
        Map<id, Account> accountsWithMap1 = new Map<id, Account>();
        for(Account acc : accounts){
            accName.add(acc.Name);
            accountsWithMap.put(acc.Name, acc.Industry);
            accountsWithMap1.put(acc.id, acc);
            system.debug('key data ' + accountsWithMap.KeySet());
            system.debug('Values data ' + accountsWithMap.Values());
        }
    }
    
    public static void multipleMap(){
        List<Account> accounts = [select id, Name, Rating, Industry from Account];
        Map<String, List<Account>> accwithMap = new Map<String, List<Account>>();
        List<Account> accList = new List<Account>();
        for(Account acc : accounts){
            accList.add(acc);
            accwithMap.Put(acc.Rating, accList);
        }
    }
}