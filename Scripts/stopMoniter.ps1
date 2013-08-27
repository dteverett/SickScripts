Function Stop()
{
    #Unregister-Event filedeleted
    Unregister-event filecreated
    Unregister-event filechanged
}