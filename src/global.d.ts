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
	street1?: string;
	street2?: string;
	city?: string;
	state?: string;
	zipCode?: string;
}

interface Contact {
	contactId?: number;
	prefix?: string;
	fullName?: string;
	suffix?: string;
	nickname?: string;
	email?: string;
	phone?: number;
	org?: string;
	title?: string;
	street?: string;
	city?: string;
	state?: string;
	zipCode?: string;
	avatar?: string;
}

interface Connection {
	connectionId?: number;
	partyId?: number;
	isPeer?: boolean;
	isSubordinate?: boolean;
	party?: Party;
}

interface Party {
	partyId?: number;
	contactId?: number;
	contact?: Contact;
	projectId?: number;
	project?: Project;
	role?: string;
	connections?: Connection[];
}

interface Property {
	propertyId?: number;
	street1?: string;
	street2?: string;
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
	parcels?: PropertiesInProjects[];
	parties?: PartiesInProjects[];
	roles?: string[];
	projectDisplayIndex?: number;
}
