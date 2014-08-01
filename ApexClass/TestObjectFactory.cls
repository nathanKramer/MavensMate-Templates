/**
 * TestObjectFactory.cls
 * Description: Class facilitating retrieval of test records etc
 * @author: Trineo
 */
@isTest 
public class TestObjectFactory {

    private static Integer uniqueCounter = 0;
    private static String getUniqueCounter() {
        return String.valueOf(uniqueCounter++);
    }
       
    /**
     * Return a new Standard User for running tests as. You may need additional fields initialised depending on
     * the org's customisations (and business processes), but this should work out of the box in most orgs, at 
     * least as a starting point.
     */
    public static User createTestUser(Boolean shouldInsert) {
        ID profID = [SELECT ID FROM Profile WHERE Name='Standard User'].ID;
        
        User newUser = new User(
                ProfileID =  profID,
                Username = (math.random() + '@fake.invalid.blarg'), 
                LastName = ('testLName' + math.random()), 
                Email = (math.random() + '@fake.invalid.blarg'), 
                Alias = String.valueOf(math.random()).right(6), 
                CommunityNickname = ('testComName' + math.random()), 
                TimeZoneSidKey = 'Pacific/Auckland', 
                LocaleSidKey = 'en_GB', 
                EmailEncodingKey = 'UTF-8', 
                LanguageLocaleKey = 'en_US'
            );

        if (shouldInsert) insert newUser;
        return newUser;
    }

    /**
     * Retrieve a test account record
     * @param String accountName : the name of the account to create
     * @param Boolean shouldInsert : if true, record will be inserted, otherwise you must insert it yourself
     */
    public static Account getAccount(String accountName, Boolean shouldInsert) {
        Account theAccount = new Account(Name = accountName);
        if (shouldInsert) insert theAccount;

        return theAccount;
    }

    /**
     * Retrieve a test account record
     * @param Boolean shouldInsert : if true, record will be inserted, otherwise you must insert it yourself
     */
    public static Account getAccount(Boolean shouldInsert) {
        return getAccount('TestAccount' + getUniqueCounter(), shouldInsert);
    }
}
  