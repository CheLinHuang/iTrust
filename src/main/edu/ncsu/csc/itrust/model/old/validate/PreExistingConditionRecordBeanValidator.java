package edu.ncsu.csc.itrust.model.old.validate;

import edu.ncsu.csc.itrust.exception.ErrorList;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.model.old.beans.PreExistingConditionRecordBean;

public class PreExistingConditionRecordBeanValidator extends BeanValidator<PreExistingConditionRecordBean> {

    // The default constructor.
    public PreExistingConditionRecordBeanValidator() {

    }

    @Override
    public void validate(PreExistingConditionRecordBean bean) throws FormValidationException {
        ErrorList errorList = new ErrorList();
        errorList.addIfNotNull(checkFormat("patientMID", bean.getPatientMID(), ValidationFormat.MID, false));
        errorList.addIfNotNull(checkFormat("icdInfo", bean.getIcdInfo(), ValidationFormat.ICD, false));

        if (errorList.hasErrors()) {
            throw new FormValidationException(errorList);
        }
    }
}
