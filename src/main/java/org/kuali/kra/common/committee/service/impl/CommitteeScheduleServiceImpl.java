/*
 * Copyright 2005-2010 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.kra.common.committee.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.time.DateUtils;
import org.kuali.kra.bo.KraPersistableBusinessObjectBase;
import org.kuali.kra.common.committee.bo.CommonCommittee;
import org.kuali.kra.common.committee.bo.CommonCommitteeSchedule;
import org.kuali.kra.common.committee.bo.ScheduleStatus;
import org.kuali.kra.common.committee.meeting.CommitteeScheduleAttachments;
import org.kuali.kra.common.committee.meeting.CommitteeScheduleMinute;
import org.kuali.kra.common.committee.service.CommonCommitteeScheduleService;
import org.kuali.kra.common.committee.web.struts.form.schedule.DailyScheduleDetails;
import org.kuali.kra.common.committee.web.struts.form.schedule.MonthlyScheduleDetails;
import org.kuali.kra.common.committee.web.struts.form.schedule.ScheduleData;
import org.kuali.kra.common.committee.web.struts.form.schedule.StyleKey;
import org.kuali.kra.common.committee.web.struts.form.schedule.YearlyScheduleDetails;
import org.kuali.kra.protocol.Protocol;
import org.kuali.kra.protocol.actions.reviewcomments.ReviewCommentsService;
import org.kuali.kra.scheduling.expr.util.CronSpecialChars;
import org.kuali.kra.scheduling.sequence.DefaultScheduleSequence;
import org.kuali.kra.scheduling.sequence.ScheduleSequence;
import org.kuali.kra.scheduling.sequence.TrimDatesScheduleSequenceDecorator;
import org.kuali.kra.scheduling.sequence.WeekScheduleSequenceDecorator;
import org.kuali.kra.scheduling.service.ScheduleService;
import org.kuali.kra.scheduling.util.Time24HrFmt;
import org.kuali.rice.kns.util.WebUtils;
import org.kuali.rice.krad.service.BusinessObjectService;
import org.springframework.transaction.annotation.Transactional;


/**
 * The Committee Service implementation.
 */
@Transactional
public class CommitteeScheduleServiceImpl implements CommonCommitteeScheduleService {
    
    @SuppressWarnings("unused")
    private static final org.apache.commons.logging.Log LOG = org.apache.commons.logging.LogFactory.getLog(CommitteeScheduleServiceImpl.class);
    
    private static final String COLON = ":";
    
    private static final String DESCRIPTION = "description";
    
    private static final String SCHEDULED = "Scheduled";
    
    // Changed db col names to  java ref var names during IACUC refactoring, should not cause any issues during backfitting
    private static final String PROTOCOL_ID_FIELD = "protocolIdFk";
    private static final String SCHEDULE_ID_FIELD = "scheduleIdFk";
    private static final String COMM_SCHEDULE_MINUTES_FIELD = "commScheduleMinutesId";
    private static final String ENTRY_NUMBER_FIELD = "entryNumber";
    private static final String SUBMISSION_ID_FIELD = "submissionIdFk";
    private static final String COMM_SCHEDULE_MINUTES_ID_PROPERTY = "commScheduleMinutesId";
    private BusinessObjectService businessObjectService;

    private ScheduleService scheduleService;   


    private ReviewCommentsService<?> reviewCommentsService;

    
    /**
     * Set the Business Object Service.
     * @param businessObjectService the Business Object Service
     */
    public void setBusinessObjectService(BusinessObjectService businessObjectService) {
        this.businessObjectService = businessObjectService;
    }    
    
    /**
     * Set the Schedule Service.
     * @param scheduleService
     */
    public void setScheduleService(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }
    
    /**
     * 
     * Set the ReviewComments Service.
     * @param reviewCommentsService
     */
   
    public void setReviewCommentsService(ReviewCommentsService reviewCommentsService) {
        this.reviewCommentsService = reviewCommentsService;
    }
    
    /**
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#isCommitteeScheduleDeletable(org.kuali.kra.common.committee.bo.CommonCommitteeSchedule)
     */
    public Boolean isCommitteeScheduleDeletable(CommonCommitteeSchedule committeeSchedule){
        
        boolean retVal = false;
        
        retVal = !isProtocolAssignedToScheduleDate(committeeSchedule);

        return retVal;
    }
       
    /**
     * Helper method to check if Protocol is assigned to CommitteeSchedule.
     * @param committeeSchedule
     * @return
     */
    protected Boolean isProtocolAssignedToScheduleDate(CommonCommitteeSchedule committeeSchedule){
        boolean retVal = true;
        List<Protocol> list = committeeSchedule.getProtocols();
        if(null == list || list.size() == 0)
            retVal = false;
        return retVal;
    }

    /**
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#addSchedule(org.kuali.kra.common.committee.web.struts.form.schedule.ScheduleData, org.kuali.kra.common.committee.bo.CommonCommittee)
     */
    public void addSchedule(ScheduleData scheduleData, CommonCommittee committee) throws ParseException {
        
        List<Date> dates = null;
        Date dtEnd = null;
        int frequency = 0;
        int day = 0;
        CronSpecialChars[] weekdays = null;
        CronSpecialChars weekOfMonth = null;
        CronSpecialChars dayOfWeek = null;
        CronSpecialChars month = null;
        
        Time24HrFmt time = getTime24hFmt(scheduleData.getScheduleStartDate(), scheduleData.getTime().findMinutes());
        Date dt = scheduleData.getScheduleStartDate();       
        
        StyleKey key = StyleKey.valueOf(scheduleData.getRecurrenceType());        
        switch (key) {
            case NEVER :
                dates = scheduleService.getScheduledDates(dt, dt, time, null);
                break;
            case DAILY : 
                DailyScheduleDetails.optionValues dailyoption = DailyScheduleDetails.optionValues.valueOf(scheduleData.getDailySchedule().getDayOption());
                switch (dailyoption) {
                    case XDAY: 
                        dtEnd = scheduleData.getDailySchedule().getScheduleEndDate();
                        day = scheduleData.getDailySchedule().getDay();
                        dates = scheduleService.getIntervalInDaysScheduledDates(dt, dtEnd, time, day);
                        break;
                    case WEEKDAY : 
                        dtEnd = scheduleData.getDailySchedule().getScheduleEndDate();                        
                        weekdays = ScheduleData.convertToWeekdays(scheduleData.getDailySchedule().getDaysOfWeek());
                        ScheduleSequence scheduleSequence = new WeekScheduleSequenceDecorator(new TrimDatesScheduleSequenceDecorator(new DefaultScheduleSequence()),1,weekdays.length);
                        dates = scheduleService.getScheduledDates(dt, dtEnd, time, weekdays, scheduleSequence);
                        break;
                }
                break;
            case WEEKLY :
                dtEnd = scheduleData.getWeeklySchedule().getScheduleEndDate();
                if(CollectionUtils.isNotEmpty(scheduleData.getWeeklySchedule().getDaysOfWeek())) {
                    weekdays = ScheduleData.convertToWeekdays(scheduleData.getWeeklySchedule().getDaysOfWeek().toArray(new String[scheduleData.getWeeklySchedule().getDaysOfWeek().size()]));
                }
                
                ScheduleSequence scheduleSequence = new WeekScheduleSequenceDecorator(new TrimDatesScheduleSequenceDecorator(new DefaultScheduleSequence()),scheduleData.getWeeklySchedule().getWeek(),weekdays.length);
                dates = scheduleService.getScheduledDates(dt, dtEnd, time, weekdays, scheduleSequence);
                break;
            case MONTHLY :
                MonthlyScheduleDetails.optionValues monthOption = MonthlyScheduleDetails.optionValues.valueOf(scheduleData.getMonthlySchedule().getMonthOption());
                switch(monthOption) {
                    case XDAYANDXMONTH :
                        dtEnd = scheduleData.getMonthlySchedule().getScheduleEndDate();
                        day = scheduleData.getMonthlySchedule().getDay();
                        frequency = scheduleData.getMonthlySchedule().getOption1Month();
                        dates = scheduleService.getScheduledDates(dt, dtEnd, time, day, frequency, null);
                        break;
                    case XDAYOFWEEKANDXMONTH :
                        dtEnd = scheduleData.getMonthlySchedule().getScheduleEndDate();
                        weekOfMonth = ScheduleData.getWeekOfMonth(scheduleData.getMonthlySchedule().getSelectedMonthsWeek());
                        dayOfWeek = ScheduleData.getDayOfWeek(scheduleData.getMonthlySchedule().getSelectedDayOfWeek());
                        frequency = scheduleData.getMonthlySchedule().getOption2Month();
                        dates = scheduleService.getScheduledDates(dt, dtEnd, time, dayOfWeek, weekOfMonth, frequency, null);
                        break;
                }
                break;
            case YEARLY : 
                YearlyScheduleDetails.yearOptionValues yearOption = YearlyScheduleDetails.yearOptionValues.valueOf(scheduleData.getYearlySchedule().getYearOption());
                switch(yearOption) {
                    case XDAY :
                        dtEnd = scheduleData.getYearlySchedule().getScheduleEndDate();
                        month = ScheduleData.getMonthOfWeek(scheduleData.getYearlySchedule().getSelectedOption1Month());
                        day = scheduleData.getYearlySchedule().getDay();
                        frequency = scheduleData.getYearlySchedule().getOption1Year();
                        dates = scheduleService.getScheduledDates(dt, dtEnd, time, month, day, frequency, null);
                        break;
                    case CMPLX:
                        dtEnd = scheduleData.getYearlySchedule().getScheduleEndDate();
                        weekOfMonth = ScheduleData.getWeekOfMonth(scheduleData.getYearlySchedule().getSelectedMonthsWeek());
                        dayOfWeek = ScheduleData.getDayOfWeek(scheduleData.getYearlySchedule().getSelectedDayOfWeek());
                        month = ScheduleData.getMonthOfWeek(scheduleData.getYearlySchedule().getSelectedOption2Month());
                        frequency = scheduleData.getYearlySchedule().getOption2Year();
                        dates = scheduleService.getScheduledDates(dt, dtEnd, time, weekOfMonth, dayOfWeek, month, frequency, null);
                        break;
                }
                break;            
        }
        List<java.sql.Date> skippedDates = new ArrayList<java.sql.Date>();
        scheduleData.setDatesInConflict(skippedDates);
        addScheduleDatesToCommittee(dates, committee, scheduleData.getPlace(),skippedDates);

    }
    
    /**
     * Helper method to convert date and minutes into Time24HrFmt object.
     * @param date
     * @param min
     * @return
     * @throws ParseException
     */
    protected Time24HrFmt getTime24hFmt(Date date, int min) throws ParseException{
        Date dt  = DateUtils.round(date, Calendar.DAY_OF_MONTH);            
        dt = DateUtils.addMinutes(dt, min);
        Calendar cl = new GregorianCalendar();
        cl.setTime(dt);
        StringBuffer sb = new StringBuffer();
        String str = sb.append(cl.get(Calendar.HOUR_OF_DAY)).append(COLON).append(cl.get(Calendar.MINUTE)).toString();       
        return new Time24HrFmt(str); 
    }
  
    /**
     * Helper method to add schedule to list.
     * @param dates
     * @param committee
     * @param location
     * @param skippedDates
     */
    protected void addScheduleDatesToCommittee(List<Date> dates, CommonCommittee committee, String location, List<java.sql.Date> skippedDates){
        for(Date date: dates) {
            java.sql.Date sqldate = new java.sql.Date(date.getTime());
            
            if(!isDateAvailable(committee.getCommitteeSchedules(), sqldate)){
                skippedDates.add(sqldate);
                continue;
            }
          
            CommonCommitteeSchedule committeeSchedule = new CommonCommitteeSchedule();
            committeeSchedule.setScheduledDate(sqldate);
            committeeSchedule.setPlace(location);
            committeeSchedule.setTime(new Timestamp(date.getTime()));

            int daysToAdd = committee.getAdvancedSubmissionDaysRequired();
            java.sql.Date sqlDate = calculateAdvancedSubmissionDays(date, daysToAdd);
            committeeSchedule.setProtocolSubDeadline(sqlDate);

            committeeSchedule.setCommittee(committee);

            ScheduleStatus defaultStatus = getDefaultScheduleStatus();
            committeeSchedule.setScheduleStatusCode(defaultStatus.getScheduleStatusCode());
            committeeSchedule.setScheduleStatus(defaultStatus);
                         
            committee.getCommitteeSchedules().add(committeeSchedule);            
        }
    }
    
    /**
     * Helper method to test if date is available (non conflicting).
     * @param committeeSchedules
     * @param date
     * @return
     */
    protected Boolean isDateAvailable(List<CommonCommitteeSchedule> committeeSchedules, java.sql.Date date) {
        boolean retVal = true;
        for (CommonCommitteeSchedule committeeSchedule : committeeSchedules) {
            Date scheduledDate = committeeSchedule.getScheduledDate();
            if ((scheduledDate != null) && DateUtils.isSameDay(scheduledDate, date)) {
                retVal = false;
                break;
            }
        }
        return retVal;
    }
    
    /**
     * Helper method to calculate advanced submission days.
     * @param startDate
     * @param days
     * @return
     */
    protected java.sql.Date calculateAdvancedSubmissionDays(Date startDate, Integer days){
        Date deadlineDate = DateUtils.addDays(startDate, -days);
        return new java.sql.Date(deadlineDate.getTime());
    }
    
    /**
     * Helper method to retrieve default ScheduleStatus object.
     * @return
     */
    @SuppressWarnings("unchecked")
    protected ScheduleStatus getDefaultScheduleStatus(){
        Map<String, Object> fieldValues = new HashMap<String, Object>();
        fieldValues.put(DESCRIPTION, SCHEDULED);
        List<ScheduleStatus> scheduleStatuses = (List<ScheduleStatus>)businessObjectService.findMatching(ScheduleStatus.class, fieldValues);
        return scheduleStatuses.get(0);
    }
    
    /**
     * 
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#getMinutesByProtocol(java.lang.Long)
     */
    public List<CommitteeScheduleMinute> getMinutesByProtocol(Long protocolId){
        Map<String, Object> fieldValues = new HashMap<String, Object>();
        fieldValues.put(PROTOCOL_ID_FIELD, protocolId);
        List<CommitteeScheduleMinute> minutes = (List<CommitteeScheduleMinute>)businessObjectService.findMatchingOrderBy(CommitteeScheduleMinute.class, fieldValues, ENTRY_NUMBER_FIELD, true);
        return minutes;
    }
    
    /**
     * 
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#getMinutesBySchedule(java.lang.Long)
     */
    @SuppressWarnings("unchecked")
    public List<CommitteeScheduleMinute> getMinutesBySchedule(Long scheduleId){
        Map<String, Object> fieldValues = new HashMap<String, Object>();
        List<CommitteeScheduleMinute> permittedMinutes = new ArrayList<CommitteeScheduleMinute>();
        fieldValues.put(SCHEDULE_ID_FIELD, scheduleId);
        List<CommitteeScheduleMinute> minutes = (List<CommitteeScheduleMinute>)businessObjectService.findMatchingOrderBy(CommitteeScheduleMinute.class, fieldValues, ENTRY_NUMBER_FIELD, true);
        for (CommitteeScheduleMinute minute : minutes) {
            if(reviewCommentsService.getReviewerCommentsView(minute)){
                permittedMinutes.add(minute);
            }
        }
        
        return permittedMinutes;
    }
      
    /**
     * 
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#getCommitteeScheduleMinute(java.lang.Long)
     */
    public CommitteeScheduleMinute getCommitteeScheduleMinute(Long committeeScheduleId){
        Map<String, Object> fieldValues = new HashMap<String, Object>();
        fieldValues.put(COMM_SCHEDULE_MINUTES_ID_PROPERTY, committeeScheduleId);
        List<CommitteeScheduleMinute> minutes = (List<CommitteeScheduleMinute>)businessObjectService.findMatching(CommitteeScheduleMinute.class, fieldValues);
        if(minutes.size() == 1){
            return minutes.get(0);
        }else{
            return null;
        }
    }
    
    /**
     * 
     * @see org.kuali.kra.common.committee.service.CommonCommitteeScheduleService#getMinutesByProtocolSubmission(java.lang.Long)
     */
    public List<CommitteeScheduleMinute> getMinutesByProtocolSubmission(Long submissionID){
        Map<String, Object> fieldValues = new HashMap<String, Object>();
        List<CommitteeScheduleMinute> permittedMinutes = new ArrayList<CommitteeScheduleMinute>();
        fieldValues.put(SUBMISSION_ID_FIELD, submissionID);
        List<CommitteeScheduleMinute> minutes = (List<CommitteeScheduleMinute>)businessObjectService.findMatchingOrderBy(CommitteeScheduleMinute.class, fieldValues, ENTRY_NUMBER_FIELD, true);
        for (CommitteeScheduleMinute minute : minutes) {
            if(reviewCommentsService.getReviewerCommentsView(minute)){
                permittedMinutes.add(minute);
            }
        }
        return permittedMinutes;
    }
    /**
     * This method will downloadAttachment  to CommitteeScheduleAttachments.
     * @param committeScheduleAttachments
     * @return
     */
    @Override
    public void downloadAttachment(KraPersistableBusinessObjectBase attachmentDataSource, HttpServletResponse response) throws Exception {
    	CommitteeScheduleAttachments committeScheduleAttachments = new CommitteeScheduleAttachments();
        byte[] data = null;
        String contentType = null;
        String fileName = null;
        if(attachmentDataSource.getClass().isInstance(committeScheduleAttachments)){
            committeScheduleAttachments =(CommitteeScheduleAttachments)attachmentDataSource;
            data = committeScheduleAttachments.getData();
            contentType = committeScheduleAttachments.getContentType();
            fileName = committeScheduleAttachments.getFileName();
        }
        ByteArrayOutputStream baos = null;
        try {
            baos = new ByteArrayOutputStream(data.length);
            baos.write(data);
            WebUtils.saveMimeOutputStreamAsFile(response, contentType, baos, fileName);
        } finally {
        	try {
                if (baos != null) {
                    baos.close();
                    baos = null;
                }
            } catch (IOException ioEx) {
               
            }
        }
    }	
}
