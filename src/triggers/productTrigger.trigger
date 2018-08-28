trigger productTrigger on Product_Table__c (before insert) {
	TriggerHandler handler = new TriggerHandler();
    handler.onBefore(trigger.new);
}