/// <reference types="@sveltejs/kit" />

interface CurrentUser {
	firstName: string;
	lastName: string;
	email: string;
	role: string;
	avatar: string;
}

interface User {
	userId: string;
	firstName: string;
	lastName?: string;
	email: string;
	password?: string;
	avatar?: string;
	role: 'user' | 'admin';
	createdAt: string;
	person?: Person;
}

interface UserSignup {
	email: string;
	password: string;
	passConfirm: string;
}

interface UserLogin {
	email: string;
	password: string;
}

interface Address {
	street?: string;
	city?: string;
	state?: string;
	zipCode?: string;
}

interface Contact {
	contactId?: number;
	prefix?: string;
	firstName?: string;
	lastName?: string;
	suffix?: string;
	fullName?: string;
	nickname?: string;
	email?: string;
	phone?: string;
	org?: string;
	title?: string;
	street?: string;
	city?: string;
	state?: string;
	zipCode?: string;
	avatar?: string;
}

interface Party {
	partyId?: number;
	contactId?: number;
	contact?: Contact;
	projectId?: number;
	project?: Project;
	role?: string;
	manages?: Party[];
	managedBy?: Party[];
}

interface Property {
	propertyId?: number;
	street?: string;
	city?: string;
	state?: string;
	zipCode?: string;
	country?: string;
	county?: string;
	parcelId?: string;
	shortDescription?: string;
	legalDescription?: string;
	projects?: number[];
}

interface ParcelsInProjects {
	propertyId?: number;
	property?: Property;
	projectId?: number;
	project?: Project;
	vesting?: string;
	assessedValue?: number;
	assessedYear?: number;
	updatedAt?: Date;
}

interface Project {
	projectId?: number;
	projectType?: string;
	createdBy?: User;
	createdAt?: Date;
	updatedBy?: User;
	updatedAt?: Date;
	parcels?: ParcelsInProjects[];
	parties?: Party[];
	roles?: string[];
	projectDisplayIndex?: number;
}
