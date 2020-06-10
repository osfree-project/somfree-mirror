/**************************************************************************
 *
 *  Copyright 1994, Christina Lau
 *
 *  This file is part of Object-Orientated Programming using SOM and DSOM.
 *
 *  This program is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License as published by the
 *  Free Software Foundation, either version 3 of the License, or (at your
 *  option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 *  This file was generated by the SOM Compiler and Emitter Framework.
 *  Generated using: 
 *      SOM Emitter emitxtm: somc/smmain.c
 */

#define Day_Class_Source
#include <day.xih>
#include <workitem.xh>
#include <string.h>

SOM_Scope short  SOMLINK book(Day *somSelf,  Environment *ev,
                              WorkItem* entry)
{
    DayData *somThis = DayGetData(somSelf);
    short rc;
    DayMethodDebug("Day","book");

    if (sequenceLength(somThis->workList) < sequenceMaximum(somThis->workList))
    {
      sequenceElement(somThis->workList,
                      sequenceLength(somThis->workList)) = entry;
      sequenceLength(somThis->workList)++;

      somSelf->sompSetDirty(ev);
      entry->sompInitNearObject(ev, somSelf);

      rc = 0L;
    }
    else
      rc = -1L;

    return rc;
}

SOM_Scope short  SOMLINK removeItem(Day *somSelf,  Environment *ev,
                                string start, string end, string desc)
{
    DayData *somThis = DayGetData(somSelf);
    short    i;
    WorkItem *item;
    DayMethodDebug("Day","removeItem");

    for (i=0; i < sequenceLength(somThis->workList); i++ )
    {
      item = sequenceElement(somThis->workList,i);

      if ( (strcmp(start, item->_get_startTime(ev)) == 0) &&
           (strcmp(end, item->_get_endTime(ev)) == 0) &&
           (strcmp(desc, item->_get_task(ev)) == 0) )
      {
         sequenceLength(somThis->workList)--;
                                                                         
         for (i; i < sequenceLength(somThis->workList); i++)
         {
           sequenceElement(somThis->workList,i) =
             sequenceElement(somThis->workList, i+1);
         }

         somSelf->sompSetDirty(ev);
         return 0;
      }
    }
    return -1L;       // item not found
}

SOM_Scope void  SOMLINK somInit(Day *somSelf)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somInit");

    Day_parent_SOMPPersistentObject_somInit(somSelf);

    sequenceMaximum(somThis->workList) = MAXITEM;
    sequenceLength(somThis->workList) = 0;
    somThis->workList._buffer =
       (WorkItem**) SOMMalloc(sizeof (WorkItem *) * MAXITEM);
}

SOM_Scope void  SOMLINK somUninit(Day *somSelf)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somUninit");

    if (somThis->workList._buffer)
       SOMFree(somThis->workList._buffer);

    Day_parent_SOMPPersistentObject_somUninit(somSelf);
}


SOM_Scope boolean  SOMLINK sompIsDirty(Day *somSelf,  Environment *ev)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","sompIsDirty");

    return (somSelf->sompGetDirty(ev));
}

