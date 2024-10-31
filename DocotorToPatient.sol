// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DocotorToPatient{
    address public doctor;

   
    struct Patient{
       string email;
         string name;
         uint age;
        

    }
    constructor(){
        doctor=msg.sender;
    }

    struct PatientRecord{
        string email;
        uint age;
        string name;
        string date;
        string testReportStatus;
        string Prescribtions;
        bool verified;
    }


        struct NotVerifiedarray{
        uint repono;
        string email;
        uint age;
        string name;
        string date;
        string testReportStatus;
        bool verified;
    }

    uint labreportno=1;
NotVerifiedarray[] public notVeriifed;
   function NotVerifiedStored( 
        string memory email,
        uint age,
        string memory name,
        string memory date,
        string memory testReportStatus
     ) public {
         
            notVeriifed.push(NotVerifiedarray(labreportno,email,age,name,date,testReportStatus,false));
            labreportno++;

        }



PatientRecord[] public patientRecord;

Patient[] public patients;
 mapping(address=>bool) public rigistered;
    mapping(address=>string)PatientUniqId;
    function addPatient(string memory email,string memory name, uint age) public{
        patients.push(Patient(email,name,age));
        PatientUniqId[msg.sender]=email;
     
    rigistered[msg.sender]=true;

    }
function getPateints() public view returns(Patient[] memory)
{
    return patients;
}
    function isRegistered(address add) public view returns (bool)
    {
        return rigistered[add];
    }

    function addRecords(string memory email,
        uint age,
        string memory name,
        string memory date,
        string memory testReportStatus,
        string memory Prescribtions) public {
            require(msg.sender==doctor,"only doctor can add patients record");
            patientRecord.push(PatientRecord(email,age,name,date,testReportStatus,Prescribtions,true));

        }

         function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

        function getpatientRecord(string memory email)public view returns(PatientRecord[] memory){
            
             uint counter=0;
             for(uint j=0;j<patientRecord.length;j++)
             {
                string memory Emails=patientRecord[j].email;
                if(compareStrings(Emails,email))
                {
                    counter++;
                }
             }

              PatientRecord[] memory internalPateintRecord=new PatientRecord[](counter);
              uint k=0;
               for(uint j=0;j<patientRecord.length;j++)
             {
                
                string memory Emails=patientRecord[j].email;
                if(compareStrings(Emails,email))
                {
                    internalPateintRecord[k]=PatientRecord(patientRecord[j].email,patientRecord[j].age,patientRecord[j].name,patientRecord[j].date,patientRecord[j].testReportStatus,patientRecord[j].Prescribtions,patientRecord[j].verified);
                    k++;
                }
             }
             return internalPateintRecord;

        }

        function toVerify(uint labReportNo,string memory presc)public{
            require(msg.sender==doctor,"only docotor can verify");

            for(uint z=0;z<notVeriifed.length;z++)
            {
                if(notVeriifed[z].repono==labReportNo)
                {
                    notVeriifed[z].verified=true;
                    addRecords(notVeriifed[z].email,notVeriifed[z].age,notVeriifed[z].name,notVeriifed[z].date,notVeriifed[z].testReportStatus,presc);
                }

            }

        }

    function getPatients() public view returns(Patient[] memory){
        return patients;
    }

         function labTestedNotVerifiedRecords()public view returns(NotVerifiedarray[] memory){
            
             uint counter=0;
             for(uint j=0;j<notVeriifed.length;j++)
             {
                if(notVeriifed[j].verified==false)
                {
                    counter++;
                }
             }

              NotVerifiedarray[] memory internalnotVeriifed=new NotVerifiedarray[](counter);
               uint k=0;
               for(uint j=0;j<notVeriifed.length;j++)
             {
               
                if(notVeriifed[j].verified==false)
                {
                    internalnotVeriifed[k]=NotVerifiedarray(notVeriifed[j].repono,notVeriifed[j].email,notVeriifed[j].age,notVeriifed[j].name,notVeriifed[j].date,notVeriifed[j].testReportStatus,notVeriifed[j].verified);
                    k++;

                }
             }
             return internalnotVeriifed;

             //Grey's Anatomy. // St. Jude's Hospital

        }




}